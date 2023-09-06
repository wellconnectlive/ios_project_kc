//
//  VerificationEmailViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 10/8/23.
//

import Foundation
import FirebaseAuth



class VerificationEmailViewModel: ObservableObject {
    var appState: AppState
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    
    @Published var verificationCode: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    init(appState: AppState) {
        self.appState = appState
    }

    func sendVerificationEmail() {
        isLoading = true
        //comprueba si el email ya existe
        checkIfEmailExists(email: Auth.auth().currentUser?.email ?? "") { emailExists in
            if emailExists {
                self.showAlertMessage(title: "Alerta", message: "El correo electrónico ya está registrado. Prueba con otro o inicia sesión con el existente.")
            } else {
                Auth.auth().currentUser?.sendEmailVerification { error in
                    if let error = error {
                        self.showAlertMessage(title: "Error", message: "Error al enviar el email de verificación: \(error.localizedDescription)")
                    } else {
                        self.showAlertMessage(title: "Éxito", message: "Email de verificación enviado exitosamente.")
                    }
                    self.isLoading = false
                }
            }
        }
    }


    func resendCode() {
        // Lógica para reenviar el código, si es necesario
    }
    //comprueba si el email ya está registrado
    func checkIfEmailExists(email: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email, completion: { methods, error in
            if let error = error {
                print("Error al verificar el email: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let methods = methods, !methods.isEmpty {
                completion(true)
            } else {
                completion(false)
            }
        })
    }


    func checkVerification() {
        isLoading = true
        Auth.auth().currentUser?.reload(completion: { error in
            if let error = error {
                self.errorMessage = "Error al recargar el usuario: \(error.localizedDescription)"
                self.isLoading = false
            } else {
                if let verified = Auth.auth().currentUser?.isEmailVerified, verified {
                    DispatchQueue.main.async {
                        self.appState.navigationState = .profile 
                    }
                } else {
                    self.errorMessage = "Por favor verifica tu email. Si no ves el correo, espera unos minutos o verifica la carpeta de spam."
                    self.isLoading = false
                }
            }
        })
    }
    
    // Función para manejar lógica de mostrar una alerta
    private func showAlertMessage(title: String, message: String) {
        DispatchQueue.main.async {
            self.errorMessage = title
            self.showAlert = true
            self.alertMessage = message
        }
    }
}

