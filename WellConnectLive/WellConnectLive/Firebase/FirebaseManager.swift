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

protocol FirestoreManagerProtocol {
    //func saveAuthUser(authUser: AuthUser, completion: @escaping (Error?) -> Void)
    //func saveUserProfile(userProfile: UserProfile, completion: @escaping (Error?) -> Void)
    //func saveUserData(userData: UserData, completion: @escaping (Error?) -> Void)
    //func getUserProfile(by id: String, completion: @escaping (UserProfile?, Error?) -> Void)
    //func getUserData(by id: String, completion: @escaping (UserData?, Error?) -> Void)
    //func uploadImageAndSaveReference(userId: String, imageData: Data, completion: @escaping (Error?) -> Void)
}


class FirestoreManager: FirestoreManagerProtocol {
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
    func updateContactsForUser(with id: String, contacts: [Contact], completion: @escaping (Error?) -> Void) {
        let ref = db.collection("userDatas").document(id)
        
        // Aquí solo actualizamos el campo 'contacts' con el nuevo array de contactos.
        let contactData = contacts.map { $0.toDocumentData() }
        ref.updateData(["contacts": contactData], completion: completion)
    }
}


//MOCK PARA EL TEST
class FirestoreManagerMock: FirestoreManagerProtocol {
    var shouldReturnError: Bool = false
    
    func saveAuthUser(authUser: AuthUser, completion: @escaping (Error?) -> Void) {
        if shouldReturnError {
            completion(NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        } else {
            completion(nil)
        }
    }
    
    func saveUserProfile(userProfile: UserProfile, completion: @escaping (Error?) -> Void) {
        if shouldReturnError {
            completion(NSError(domain: "", code: 998, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        } else {
            completion(nil)
        }
    }
    
    func saveUserData(userData: UserData, completion: @escaping (Error?) -> Void) {
        if shouldReturnError {
            completion(NSError(domain: "", code: 997, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        } else {
            completion(nil)
        }
    }
    
    func getUserProfile(by id: String, completion: @escaping (UserProfile?, Error?) -> Void) {
        if shouldReturnError {
            completion(nil, NSError(domain: "", code: 996, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        } else {
            let mockProfile = UserProfile(
                id: "mockId123",
                name: "John",
                apellidoPaterno: "Doe",
                apellidoMaterno: "Smith",
                genero: .male,
                dni: "12345678",
                direccion: "123 Mock St",
                poblacion: "Mock City",
                pais: "Mockland",
                bloodType: .Aplus,
                edad: 30,
                fechaNacimiento: Date(),
                fechaInscripcion: Date(),
                phoneNumber: "123-456-7890",
                codigoPostal: 12345,
                religion: .cristianoApostolicoRomano,
                photo: "mock_photo_url",
                implants: [.marcapasos]
            )
            completion(mockProfile, nil)
        }
    }

    func getUserData(by id: String, completion: @escaping (UserData?, Error?) -> Void) {
        if shouldReturnError {
            completion(nil, NSError(domain: "", code: 995, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        } else {
            let mockDisease = Disease(type: .diabetes, name: nil, trackings: nil)
            let mockContact = Contact(
                id: "contactId123",
                name: "Jane",
                parentesco: .madre,
                email: "jane@example.com",
                phoneNumber: "987-654-3210",
                direccion: "456 Mock St",
                compartirUbicacion: true
            )
            
            let mockData = UserData(
                id: "mockDataId456",
                userType: .premium,
                note: "Mock note",
                allowTracking: true,
                contacts: [mockContact],
                diseases: [mockDisease],
                allergies: TypeAlergies(allergiesMedicamentos: [.antibioticos], allergiesAlimentacion: [.lecheDeVaca], allergiesOtros: [.polen]),
                qr: "mock_qr_code"
            )
            completion(mockData, nil)
        }
    }


    func uploadImageAndSaveReference(userId: String, imageData: Data, completion: @escaping (Error?) -> Void) {
        if shouldReturnError {
            completion(NSError(domain: "", code: 994, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        } else {
            completion(nil)
        }
    }
}


 
