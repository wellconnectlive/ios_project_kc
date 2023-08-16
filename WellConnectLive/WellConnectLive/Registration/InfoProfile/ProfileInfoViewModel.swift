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
    
    func saveUserProfileCD() {
        // guardar
    }
}


