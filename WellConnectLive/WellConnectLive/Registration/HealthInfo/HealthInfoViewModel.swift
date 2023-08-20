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

    var numberOfAllergies: Int {
        var count = 0
        count += allergiesMedicamentos.count
        count += allergiesAlimentacion.count
        count += allergiesOtros.count
        return count
    }
    
    func saveHealthInfoCD() {
        // Función para guardar la información de salud en CoreData (implementar más tarde)
    }
}
