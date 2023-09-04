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

//implementamos el protocolo para mockear una clase para los tests.
protocol AuthService {
    func registerUser(email: String, password: String, completion: @escaping (FirebaseAuthResult) -> Void)
}


class FirebaseAuthService: AuthService {
    var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func registerUser(email: String, password: String, completion: @escaping (FirebaseAuthResult) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let authResult = authResult {
                let user = AuthUser(id: authResult.user.uid, email: authResult.user.email ?? "")
                self.appState.userId = authResult.user.uid
                completion(.success(user))
            }
        }
    }
}



class MockAuthService: AuthService {
    
    // Una variable para controlar el comportamiento del mock
    var shouldReturnError: Bool = false
    
    func registerUser(email: String, password: String, completion: @escaping (FirebaseAuthResult) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(.failure(error))
            return
        }
        
        let mockUser = AuthUser(id: "mockUserID", email: email)
        completion(.success(mockUser))
    }
}









