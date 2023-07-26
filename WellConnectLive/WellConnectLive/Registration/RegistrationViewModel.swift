//
//  RegistrationViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//


import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName1 = ""
    @Published var lastName2 = ""
    @Published var dni = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var birthDate = Date()
    @Published var errorMessage = ""
    
    
    func isValidEmail() -> Bool {
        return email.contains("@") /*codigo duplicado, pero no se cómo hacerlo  en plan formal(creo un archivo con todas las comprbaciones y lo llamamos desde alli?)*/
    }
    
    ///    REGISTRO DE USUARIO
    func registerUser() {
        
        if firstName.isEmpty || lastName1.isEmpty || lastName2.isEmpty || dni.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty {
            errorMessage = "Todos los campos son requeridos."
        }
        else if !isValidEmail() {
            errorMessage = "Por favor, introduce una dirección de correo electrónico válida."
            return
        }
        
        else if password != repeatPassword {
            errorMessage = "Las contraseñas no coinciden."
        } else {
            // Añadir en Firebase
            errorMessage = ""
            print("Usuario registrado exitosamente!")
        }
    }
}
