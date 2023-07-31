//
//  InformationViewModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 30/7/23.
//

import Foundation
import Combine
import FirebaseAuth
import KeychainSwift

class InformationViewModel: ObservableObject {
    var appState: AppState // necesitamos appState para cambiar el estado de navegación
    let keychain = KeychainManager()
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            keychain.deleteUserToken() // borramos el token del keychain
            DispatchQueue.main.async {
                self.appState.navigationState = .login // volvemos a la pantalla de inicio de sesión
            }
        } catch let signOutError as NSError {
            print("Error al cerrar sesión", signOutError)
        }
    }
}
