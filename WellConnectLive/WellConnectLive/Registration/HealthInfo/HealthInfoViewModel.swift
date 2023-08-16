//
//  HealthInfoViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//

import Foundation
import Combine

class HealthInfoViewModel: ObservableObject {
    @Published var allowTracking: Bool = false
    @Published var discapacidadIntelectual: Bool = false
    @Published var diabetes: Bool = false
    @Published var hipertension: Bool = false
    @Published var allergiesMedicamentos: [AllergyMedicamentos] = []
    @Published var allergiesAlimentacion: [AllergyAlimentacion] = []
    @Published var allergiesOtros: [AllergyOtros] = []
    @Published var alzheimer: Bool = false
    @Published var autismo: Bool = false
    @Published var enfermedadVonWillebrand: Bool = false
    @Published var hemofilia: Bool = false
    @Published var demenciaSenil: Bool = false
    @Published var sordera: Bool = false

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
