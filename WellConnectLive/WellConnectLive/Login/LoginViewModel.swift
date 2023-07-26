//
//  LoginViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//


import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    // una variable para almacenar los errores
    @Published var errorMessage = ""
    // para rastrear el estado de inicio de sesión---Luego lo  pasaremos/controlaremos con Keychain
    @Published var isLoggedIn = false
    // un indicador para mostrar / ocultar el indicador de carga
    @Published var isLoading = false
    
    // Método para comprobar si el correo electrónico contiene "@"; ya que es obligatorio
    func isValidEmail() -> Bool {
        return username.contains("@")
    }

    func loginUser() {
            
            errorMessage = ""/* hay que reestablecer el email para aseguranos que si en anterior vez ha habido un error, pues que ya no salga*/

            if !isValidEmail() {
                // Si el email no es valido, establece un mensaje de error
                errorMessage = "Por favor, introduce una dirección de correo electrónico válida."
            } else {
                // Pasamos a la vista principal
            }
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
