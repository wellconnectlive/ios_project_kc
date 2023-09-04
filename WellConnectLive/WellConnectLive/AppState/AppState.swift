//
//  AppState.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import Foundation
import Combine

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
    //Predeterminado el login
    @Published var navigationState: NavigationState = .login
    @Published var userId: String? //ya que siempre pasaremos appstate para la navegacion, lo aprvechamos para facilitar el id
}

