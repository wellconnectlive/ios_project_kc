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
    
    @Published var verificationCode: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    init(appState: AppState) {
        self.appState = appState
    }

    func sendVerificationEmail() {
        isLoading = true
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                self.errorMessage = "Error al enviar el email de verificación: \(error.localizedDescription)"
            } else {
                self.errorMessage = "Email de verificación enviado exitosamente."
            }
            self.isLoading = false
        }
    }

    func resendCode() {
        // Lógica para reenviar el código, si es necesario
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
                        self.appState.navigationState = .home // Asume que hay un estado `.home` que estamos implementando con Isabel
                    }
                } else {
                    self.errorMessage = "Por favor verifica tu email. Si no ves el correo, espera unos minutos o verifica la carpeta de spam."
                    self.isLoading = false
                }
            }
        })
    }
}

