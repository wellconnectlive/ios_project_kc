//
//  AddContactViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 31/8/23.
//

import Foundation
import SwiftUI
import Combine

class AddContactPopupViewModel: ObservableObject {
    
    // Validadores
    func isValidName(_ name: String) -> Bool {
        // Comprobar que el nombre solo contenga letras
        let pattern = "^[a-zA-Z\\s]+$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: name.utf16.count)
        return regex.firstMatch(in: name, options: [], range: range) != nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Comprobar que el email contenga "@" y tenga un formato válido
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Comprobar que el número de teléfono solo contenga números y tenga al menos 9 caracteres
        let pattern = "^[0-9]{9,}$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: phoneNumber.utf16.count)
        return regex.firstMatch(in: phoneNumber, options: [], range: range) != nil
    }
    // Método para validar todos los campos
    func areValidFields(name: String, email: String, phoneNumber: String) -> Bool {
        return isValidName(name) && isValidEmail(email) && isValidPhoneNumber(phoneNumber)
    }
}
