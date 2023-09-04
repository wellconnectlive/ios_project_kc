//
//  ProfileInfoViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 13/8/23.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var apellidoPaterno: String = ""
    @Published var apellidoMaterno: String = ""
    @Published var dni: String = ""
    @Published var direccion: String = ""
    @Published var poblacion: String = ""
    @Published var pais: String = ""
    @Published var phoneNumber: String = ""
    @Published var photo: String = ""
    @Published var genero: Gender = .no
    @Published var bloodType: BloodType = .Oplus
    @Published var fechaNacimiento: Date = Date()
    @Published var religion: Religion = .No
    @Published var edad: String = ""
    @Published var codigoPostal: String = ""
    @Published var implants: [Implant] = Implant.allCases
    @Published var selectedImplant: Implant = .No

    var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func isNameValid(name: String) -> Bool {
        let nameCharacterSet = CharacterSet.letters
        return !name.trimmingCharacters(in: nameCharacterSet).isEmpty
    }

    func isPhoneNumberValid(phoneNumber: String) -> Bool {
        let phoneNumberCharacterSet = CharacterSet.decimalDigits
        return !phoneNumber.trimmingCharacters(in: phoneNumberCharacterSet).isEmpty
    }

    func isDniValid(dni: String) -> Bool {
        let dniCharacterSet = CharacterSet.alphanumerics
        return !dni.trimmingCharacters(in: dniCharacterSet).isEmpty
    }

    func isNumberValid(number: String) -> Bool {
        let numberCharacterSet = CharacterSet.decimalDigits
        return !number.trimmingCharacters(in: numberCharacterSet).isEmpty
    }
    //una funcion que muestra si son true o false, mas tarde al guardar se verifica si esta funcion es true completa o hay algun false
    func areAllFieldsValid() -> Bool {
        return isNameValid(name: name) &&
               isNameValid(name: apellidoPaterno) &&
               isNameValid(name: apellidoMaterno) &&
               isDniValid(dni: dni) &&
               isNumberValid(number: phoneNumber) &&
               isNumberValid(number: codigoPostal) &&
               isNumberValid(number: edad)
    }
    
    func saveUserProfile() {
        let edadInt = Int(edad)
        let codigoPostalInt = Int(codigoPostal)

        guard areAllFieldsValid() else {
            print("Error en la validación de los campos")
            return
        }

        guard let userId = appState.userId else {
            print("Error: userId is nil")
            return
        }

        // Crear un objeto UserProfile con los datos ingresados
        let userProfile = UserProfile(id: userId, name: name, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, genero: genero, dni: dni, direccion: direccion, poblacion: poblacion, pais: pais, bloodType: bloodType, edad: edadInt, fechaNacimiento: fechaNacimiento, phoneNumber: phoneNumber, codigoPostal: codigoPostalInt, religion: religion, photo: photo, implants: implants)
        
        
        // Crear un FirestoreManager
        let firestoreManager = FirestoreManager()
        
        // Guardar el UserProfile en Firestore
        firestoreManager.saveUserProfile(userProfile: userProfile) { error in
            if let error = error {
                print("Error al guardar el perfil de usuario: \(error)")
            } else {
                print("Perfil de usuario guardado correctamente")
                
                DispatchQueue.main.async {
                    self.appState.navigationState = .information
                }
            }
        }
    }


}


