//
//  LoginViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//


import Foundation
import Combine
import FirebaseAuth
import KeychainSwift

class LoginViewModel: ObservableObject {
    var appState: AppState
    
    @Published var username = ""
    @Published var password = ""
    // una variable para almacenar los errores
    @Published var errorMessage = ""
    // para rastrear el estado de inicio de sesión---Luego lo  pasaremos/controlaremos con Keychain
    @Published var isLoggedIn = false
    // un indicador para mostrar / ocultar el indicador de carga
    @Published var isLoading = false
    
    let keychain = KeychainManager()
    
    init(appState: AppState) {
            self.appState = appState
            if checkIfTokenExists() {
                self.isLoggedIn = true
            }
        }
    
    // Método para comprobar si el correo electrónico contiene "@"; ya que es obligatorio
    func isValidEmail() -> Bool {
        return username.contains("@")
    }

    func loginUser() {
        isLoading = true
        errorMessage = ""
        
        if !isValidEmail() {
            errorMessage = "Por favor, introduce una dirección de correo electrónico válida."
            isLoading = false
        } else {
            Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
                guard let situation = self else { return }
                if let error = error {
                    situation.errorMessage = "Error en el inicio de sesión: \(error.localizedDescription)"
                    situation.isLoading = false
                } else {
                    situation.isLoggedIn = true
                    situation.isLoading = false
                    // Aquí se guarda el token en Keychain
                    authResult?.user.getIDToken(completion: { (token, error) in
                        if let error = error {
                            print("Error obteniendo el token: \(error)")
                        } else if let token = token {
                            situation.keychain.saveUserToken(token)
                            
                            DispatchQueue.main.async {
                                situation.appState.navigationState = .home // cambiamos a la pantalla de inicio
                            }
                        }
                    })
                }
            }
        }
    }
    
    func checkIfTokenExists() -> Bool {
        if keychain.getUserToken() != nil {
            return true
        }
        return false
    }
    func loginUserPrueba() {
        isLoading = true
        // Aquí comprobamos el nombre de usuario y la contraseña con Firebase.
        //Ejemplo simple(para poder trabajar en la app)
        if username == "usuario" && password == "contraseña" {
            isLoggedIn = true
            errorMessage = ""
        } else {
            errorMessage = "El nombre de usuario o la contraseña es incorrecto."
        }
        isLoading = false
    }
}

/*
 
 import SwiftUI
 import Combine

 class LoginViewModel: ObservableObject {
     @Published var email: String = ""
     @Published var password: String = ""
     @Published var errorMessage: String = ""
     
     let authService: AuthenticationService
     
     init(authService: AuthenticationService = FirebaseAuthService()) {
         self.authService = authService
     }
     
     func loginUser() {
         authService.loginUser(email: email, password: password) { result in
             switch result {
             case .success(let user):
                 print("Usuario inició sesión con éxito!")
                 self.errorMessage = ""
                 // Aquí puedes hacer lo que necesites después de que el usuario inicie sesión
             case .failure(let error):
                 print("Error al iniciar sesión: \(error)")
                 self.errorMessage = error.localizedDescription
             }
         }
     }
 }

 
 */
