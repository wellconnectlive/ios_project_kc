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
    case verification
    case profile
    case home
    case information
    case forgotPassword
}

class AppState: ObservableObject {
    //Predeterminado el login
    @Published var navigationState: NavigationState = .login
}

