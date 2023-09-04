//
//  OtherDiseaseViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 31/8/23.
//
import Foundation
import SwiftUI
import Combine


class OtherDiseasePopupViewModel: ObservableObject {//Uso exclusivo para verificar si campos estan vacios etc. ViewModel principal HealthInfoViewModel
    
    @Published var diseases: [String] = []
    
    func isDiseaseEmpty(_ disease: String) -> String? {
        return disease.isEmpty ? "El campo de enfermedad no puede estar vacío." : nil
    }
    
    func isDiseaseDuplicated(_ disease: String) -> String? {
        return diseases.contains(disease) ? "Esta enfermedad ya ha sido añadida." : nil
    }

    func isDiseaseValid(_ disease: String) -> [String]? {
        var errors: [String] = []
        if let error = isDiseaseEmpty(disease) {
            errors.append(error)
        }
        if let error = isDiseaseDuplicated(disease) {
            errors.append(error)
        }
        return errors.isEmpty ? nil : errors
    }
}
