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
            LoginView()
        case .register:
            RegistrationView()
        }
    }
}
