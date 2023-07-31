//
//  MainStateNavigation.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import Foundation
import SwiftUI

struct MainStateNavigation: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch appState.navigationState {
        case .login:
            LoginView(appState: appState)
        case .register:
            RegistrationView(appState: appState)
        case .home:
            HomeView(appState: appState)
        case .information:
            InformationView(appState: appState)
        case .forgotPassword:
            ForgotPasswordView().environmentObject(appState) /* debo revisar por qué en otras views he tenido que usar el inicializador, me estaba dando errores*/
        
        }
    }
}
