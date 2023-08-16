//
//  FirebaseService.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 29/7/23.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FirebaseAuthResult {
    case success(AuthUser)
    case failure(Error)
}

class FirebaseAuthService {
    func registerUser(with userData: UserProfile, email: String, password: String, completion: @escaping (FirebaseAuthResult) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let authResult = authResult {
                let user = AuthUser(id: authResult.user.uid, email: authResult.user.email ?? "")
                let db = Firestore.firestore()
                db.collection("users").document(user.id).setData(userData.documentData, completion: { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(user))
                })
            }
        }
    }
}


/*
 //El error es debido a que traemos datos como User y estos son demasiados complejos para FirebaseAuth
 
protocol AuthenticationService {
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}

class FirebaseAuthService: AuthenticationService {
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
}
*/







