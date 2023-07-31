//
//  ForgotPasswordViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 31/7/23.
//

import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var error: String? = nil
    @Published var passwordResetSent: Bool = false

    func sendPasswordReset() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.error = error.localizedDescription
                } else {
                    self.passwordResetSent = true
                }
            }
        }
    }
}
