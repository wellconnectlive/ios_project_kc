//
//  FirebaseManager.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 21/8/23.
//

///IRAKASLEAK ZUZENDUTAKUA:
///


 
 import Foundation
 import FirebaseFirestore
 import FirebaseStorage

 class FirestoreManager {
     private let db = Firestore.firestore()
     private let storage = Storage.storage()

     init() {
         // Mantener la inicialización de la persistencia local.
         let settings = FirestoreSettings()
         settings.isPersistenceEnabled = true
         db.settings = settings
     }

     // Guardar un usuario en Firestore directamente
     func saveAuthUser(authUser: AuthUser, completion: @escaping (Error?) -> Void) {
         let ref = db.collection("authUsers").document(authUser.id)
         ref.setData(authUser.toDocumentData(), completion: completion)
     }

     // Guardar un perfil de usuario en Firestore directamente
     func saveUserProfile(userProfile: UserProfile, completion: @escaping (Error?) -> Void) {
         let ref = db.collection("userProfiles").document(userProfile.id)
         ref.setData(userProfile.toDocumentData(), completion: completion)
     }

     // Guardar datos de usuario en Firestore directamente
     func saveUserData(userData: UserData, completion: @escaping (Error?) -> Void) {
         let ref = db.collection("userDatas").document(userData.id)
         ref.setData(userData.toDocumentData(), completion: completion)
     }
 
    // Obtener un perfil de usuario por ID
    func getUserProfile(by id: String, completion: @escaping (UserProfile?, Error?) -> Void) {
        let ref = db.collection("userProfiles").document(id)
        ref.getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot, document.exists, let data = document.data(), let userProfile = UserProfile(from: data) else {
                completion(nil, error)
                return
            }
            completion(userProfile, nil)
        }
    }

    // Obtener datos de usuario por ID
    func getUserData(by id: String, completion: @escaping (UserData?, Error?) -> Void) {
        let ref = db.collection("userDatas").document(id)
        ref.getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot, document.exists, let data = document.data(), let userData = UserData(from: data) else {
                completion(nil, error)
                return
            }
            completion(userData, nil)
        }
    }
 
    // Subir imagen y guardar referencia en Firestore
     func uploadImageAndSaveReference(userId: String, imageData: Data, completion: @escaping (Error?) -> Void) {
         // Paso 1: Subir la imagen a Firebase Storage
         let storageRef = storage.reference().child("userImages/\(userId).jpg")
         storageRef.putData(imageData, metadata: nil) { (metadata, error) in
             if let error = error {
                 completion(error)
                 return
             }

             // Paso 2: Obtener la URL de descarga de la imagen
             storageRef.downloadURL { (url, error) in
                 if let error = error {
                     completion(error)
                     return
                 }

                 guard let downloadURL = url else {
                     completion(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Download URL not found."]))
                     return
                 }

                 // Paso 3: Guardar la URL de descarga en Firestore
                 let ref = self.db.collection("userProfiles").document(userId)
                 ref.updateData(["imageURL": downloadURL.absoluteString], completion: completion)
             }
         }
     }
 }

/*

class FirestoreManager {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    init() {
        // Habilitar la persistencia local.
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        db.settings = settings
    }

    // Guardar un usuario en caché/local
    func saveAuthUserLocally(authUser: AuthUser, completion: @escaping (Error?) -> Void) {
        let ref = db.collection("authUsers").document(authUser.id).collection("localChanges")
        ref.addDocument(data: authUser.toDocumentData(), completion: completion)
    }

    // Guardar un perfil de usuario en caché/local
    func saveUserProfileLocally(userProfile: UserProfile, completion: @escaping (Error?) -> Void) {
        let ref = db.collection("userProfiles").document(userProfile.id).collection("localChanges")
        ref.addDocument(data: userProfile.toDocumentData(), completion: completion)
    }

    // Guardar datos de usuario en caché/local
    func saveUserDataLocally(userData: UserData, completion: @escaping (Error?) -> Void) {
        let ref = db.collection("userDatas").document(userData.id).collection("localChanges")
        ref.addDocument(data: userData.toDocumentData(), completion: completion)
    }

    // Método para forzar la sincronización de los datos locales con Firestore
    func syncLocalDataToFirestore(completion: @escaping (Error?) -> Void) {
        // Aquí, iteramos sobre cada colección y subcolección de "localChanges"
        // guardamos manualmente los cambios en el servidor.
        
        let collections = ["authUsers", "userProfiles", "userDatas"]
        
        for collection in collections {
            let docsRef = db.collection(collection)
            docsRef.getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    completion(error)
                    return
                }
                
                for doc in documents {
                    let localChangesRef = docsRef.document(doc.documentID).collection("localChanges")
                    localChangesRef.getDocuments { (localChangesSnapshot, error) in
                        guard let localChanges = localChangesSnapshot?.documents else {
                            completion(error)
                            return
                        }
                        
                        for change in localChanges {
                            let data = change.data()
                            docsRef.document(doc.documentID).setData(data) { error in
                                if let error = error {
                                    completion(error)
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        
        completion(nil)
    }

    // Método para limpiar los datos locales después de una sincronización exitosa
    func clearLocalData(completion: @escaping (Error?) -> Void) {
        let collections = ["authUsers", "userProfiles", "userDatas"]
        
        for collection in collections {
            let docsRef = db.collection(collection)
            docsRef.getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    completion(error)
                    return
                }
                
                for doc in documents {
                    let localChangesRef = docsRef.document(doc.documentID).collection("localChanges")
                    localChangesRef.getDocuments { (localChangesSnapshot, error) in
                        guard let localChanges = localChangesSnapshot?.documents else {
                            completion(error)
                            return
                        }
                        
                        for change in localChanges {
                            localChangesRef.document(change.documentID).delete() { error in
                                if let error = error {
                                    completion(error)
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        
        completion(nil)
    }

    // Obtener un usuario por ID
    func getAuthUser(by id: String, completion: @escaping (AuthUser?, Error?) -> Void) {
        let ref = db.collection("authUsers").document(id)
        ref.getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot, document.exists, let data = document.data(), let user = AuthUser(from: data) else {
                completion(nil, error)
                return
            }
            completion(user, nil)
        }
    }

    // Obtener un perfil de usuario por ID
    func getUserProfile(by id: String, completion: @escaping (UserProfile?, Error?) -> Void) {
        let ref = db.collection("userProfiles").document(id)
        ref.getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot, document.exists, let data = document.data(), let userProfile = UserProfile(from: data) else {
                completion(nil, error)
                return
            }
            completion(userProfile, nil)
        }
    }

    // Obtener datos de usuario por ID
    func getUserData(by id: String, completion: @escaping (UserData?, Error?) -> Void) {
        let ref = db.collection("userDatas").document(id)
        ref.getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot, document.exists, let data = document.data(), let userData = UserData(from: data) else {
                completion(nil, error)
                return
            }
            completion(userData, nil)
        }
    }
    
    // Subir imagen y guardar referencia en Firestore
    func uploadImageAndSaveReference(userId: String, imageData: Data, completion: @escaping (Error?) -> Void) {
        // Paso 1: Subir la imagen a Firebase Storage
        let storageRef = storage.reference().child("userImages/\(userId).jpg")
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(error)
                return
            }

            // Paso 2: Obtener la URL de descarga de la imagen
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(error)
                    return
                }

                guard let downloadURL = url else {
                    completion(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Download URL not found."]))
                    return
                }

                // Paso 3: Guardar la URL de descarga en Firestore
                let ref = self.db.collection("userProfiles").document(userId)
                ref.updateData(["imageURL": downloadURL.absoluteString]) { error in
                    completion(error)
                }
            }
        }
    }
}

*/

 
