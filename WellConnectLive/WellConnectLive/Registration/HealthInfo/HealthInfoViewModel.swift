//
//  HealthInfoViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//

import Foundation
import Combine

class HealthInfoViewModel: ObservableObject {
    @Published var userData: UserData = UserData(id: "")
    @Published var diseases: [Disease] = []
    
    @Published var allowTracking: Bool = false
    @Published var allergiesMedicamentos: [AllergyMedicamentos] = []
    @Published var allergiesAlimentacion: [AllergyAlimentacion] = []
    @Published var allergiesOtros: [AllergyOtros] = []
    @Published var allergyDescription: String = ""

    var appState: AppState
        
    init(appState: AppState) {
        self.appState = appState
    }
    
    var numberOfAllergies: Int {
        var count = 0
        count += allergiesMedicamentos.count
        count += allergiesAlimentacion.count
        count += allergiesOtros.count
        if !allergyDescription.isEmpty { count += 1 }
        return count
    }
    
    func isTrackingAllowed() -> Bool {
        return allowTracking
    }

    // Función que muestra si todas las validaciones son true o hay algún false
    func areAllValidationsTrue() -> Bool {
        return isTrackingAllowed()
    }
    
    func saveHealthInfo() {
        guard let userId = appState.userId else {
            print("Error: userId is nil")
            return
        }
        
        guard areAllValidationsTrue() else {
            print("Error en la validación de los campos")
            return
        }
        
        userData.id = userId
        userData.allowTracking = allowTracking
        userData.diseases = diseases
        userData.allergies = TypeAlergies(allergiesMedicamentos: allergiesMedicamentos, allergiesAlimentacion: allergiesAlimentacion, allergiesOtros: allergiesOtros, allergyDescription:  allergyDescription)

        // Guarda userData en Firestore
        FirestoreManager().saveUserData(userData: self.userData) { error in
            if let error = error {
                // Manejar el error, por ejemplo, mostrar un mensaje al usuario
                print("Error al guardar la información de salud: \(error)")
            } else {
                // Los datos se guardaron correctamente
                print("Información de salud guardada correctamente")
                DispatchQueue.main.async {
                    self.appState.navigationState = .circleOfTrust
                }
            }
        }
    }
}

