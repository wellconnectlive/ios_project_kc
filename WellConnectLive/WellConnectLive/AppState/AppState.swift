//
//  AppState.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import Foundation
import Combine
import SwiftUI

//Para cuando se navegue entre vista AppState se encargará de saber cuál es la view destino
enum NavigationState {
    /* añadir cada vista que tengamos para su navegación*/
    case login
    case register
    case onboarding
    case verification
    case profile
    
    case information
    case circleOfTrust
    case forgotPassword
    case home
}

class AppState: ObservableObject {
    
    @Published var userId: String? //ya que siempre pasaremos appstate para la navegacion, lo aprvechamos para facilitar el id
    
    //Predeterminado el login
    @State private var pageIndex = UserDefaults.standard.string(forKey: "pageIndex")
    @Published var navigationState: NavigationState = .home//Alex

    
    init() {
            if let pageIndexString = pageIndex, let pageIndexValue = Int(pageIndexString) {
                if pageIndexValue == 3 {
                    navigationState = .login  //TODO: Cambiar a login
                } else {
                    pageIndex = "0"

                    // Guarda el valor 0 en UserDefaults para no generar inconsistencia
                    UserDefaults.standard.set(pageIndex, forKey: "pageIndex")
                    navigationState = .onboarding
                    
                }
            } else {
                //En caso de que no logre desempaquetarse el pageIndex va al onboarding
                navigationState = .onboarding
            }
        }
    
}

