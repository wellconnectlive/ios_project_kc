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
    var authService: AuthService //para el mock y el test
    
    @Published var username = ""
    @Published var password = ""
    // una variable para almacenar los errores
    @Published var errorMessage = ""
    // para rastrear el estado de inicio de sesión---Luego lo  pasaremos/controlaremos con Keychain
    @Published var isLoggedIn = false
    // un indicador para mostrar / ocultar el indicador de carga
    @Published var isLoading = false
    
    let keychain = KeychainManager()
    
    // Este es el inicializador principal que acepta explícitamente un AuthService
    init(appState: AppState, authService: AuthService) {
        self.appState = appState
        self.authService = authService
        if checkIfTokenExists() {
            self.isLoggedIn = true
        }
    }
    
    // Esta es una sobrecarga del inicializador que proporciona el valor predeterminado
    convenience init(appState: AppState) {
        self.init(appState: appState, authService: FirebaseAuthService(appState: appState))
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
            return
        }

        authService.registerUser(email: username, password: password) { [weak self] result in
            guard let self = self else { return }

            switch result {
            //pata tests
            case .success(let user):
                // Aquí manejas la lógica para un inicio de sesión exitoso
                self.isLoggedIn = true
                self.errorMessage = ""

                // Aquí se guarda el token en Keychain
                Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
                    if let error = error {
                        print("Error obteniendo el token: \(error)")
                    } else if let token = token {
                        self.keychain.saveUserToken(token)
                        
                        DispatchQueue.main.async {
                            self.appState.navigationState = .home
                        }
                    }
                })
            //Para los Tests
            case .failure(let error):
                self.errorMessage = "Error en el inicio de sesión: \(error.localizedDescription)"
            }

            self.isLoading = false
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

