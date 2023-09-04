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
    
    var appState: AppState
        
    init(appState: AppState) {
        self.appState = appState
    }
    
    var numberOfAllergies: Int {
        var count = 0
        count += allergiesMedicamentos.count
        count += allergiesAlimentacion.count
        count += allergiesOtros.count
        return count
    }
    
    func isTrackingAllowed() -> Bool {
        return allowTracking
    }

    func areAllRequiredDiseasesInformed() -> Bool {
        let requiredDiseases: [Disease.DiseaseType] = [.diabetes, .hipertension]
        for requiredDisease in requiredDiseases {
            if !diseases.contains(where: { $0.type == requiredDisease }) {
                return false
            }
        }
        return true
    }

    func areAllRequiredAllergiesInformed() -> Bool {
        let requiredAllergies: [AllergyMedicamentos] = [.penicilina]
        for requiredAllergy in requiredAllergies {
            if !allergiesMedicamentos.contains(requiredAllergy) {
                return false
            }
        }
        return true
    }

    // Función que muestra si todas las validaciones son true o hay algún false
    func areAllValidationsTrue() -> Bool {
        return isTrackingAllowed() &&
               areAllRequiredDiseasesInformed() &&
               areAllRequiredAllergiesInformed()
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
        
        // Actualiza userData con los valores actuales
        userData.id = userId
        userData.allowTracking = allowTracking
        userData.diseases = diseases
        userData.allergies = TypeAlergies(allergiesMedicamentos: allergiesMedicamentos, allergiesAlimentacion: allergiesAlimentacion, allergiesOtros: allergiesOtros)


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
