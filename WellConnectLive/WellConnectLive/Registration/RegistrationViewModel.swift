//
//  RegistrationViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//
import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore


class RegistrationViewModel: ObservableObject {
    
    
    @Published var firstName = ""
    @Published var lastName1 = ""
    @Published var lastName2 = ""
    @Published var dni = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var fechaInscripcion = Date()
    @Published var errorMessage = ""
    
    var appState: AppState
        
    init(appState: AppState) {
        self.appState = appState
    }
    
    func isValidEmail() -> Bool {
        return email.contains("@")
    }
    
    /// REGISTRO DE USUARIO
    func registerUser() {
        // Comprueba si los campos están vacíos
        guard !firstName.isEmpty, !lastName1.isEmpty, !lastName2.isEmpty, !dni.isEmpty, !email.isEmpty, !password.isEmpty, !repeatPassword.isEmpty else {
            errorMessage = "Todos los campos son requeridos."
            return
        }

        // Comprueba si el correo electrónico es válido
        guard isValidEmail() else {
            errorMessage = "Por favor, introduce una dirección de correo electrónico válida."
            return
        }

        // Comprueba si las contraseñas coinciden
        guard password == repeatPassword else {
            errorMessage = "Las contraseñas no coinciden."
            return
        }

        // Crea un objeto UserRegister a partir de los datos actuales
        let userData = UserRegister(id: UUID().uuidString, name: firstName, apellidoPaterno: lastName1, apellidoMaterno: lastName2, fechaInscripcion: fechaInscripcion, dni: dni)
        /*
         
         El método registerUser(with:email:password:completion:) en tu servicio FirebaseAuthService realiza la autenticación con Firebase usando el email y la contraseña proporcionados. Si la autenticación tiene éxito, se crea un nuevo usuario y se guarda en Firestore.
         */
        let authService = FirebaseAuthService()
        authService.registerUser(with: userData, email: email, password: password) { (result) in
            switch result {
            case .success(let user):
                self.errorMessage = ""
            case .failure(let error):
                self.errorMessage = "Error registrando el usuario: \(error.localizedDescription)"
            }
        }
    }
}



