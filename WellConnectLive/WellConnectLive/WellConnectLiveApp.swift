//
//  WellConnectLiveApp.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import SwiftUI


@main
struct wellnesstrackApp: App {
    let persistenceController = PersistenceController.shared
    //Para observar cualquier cambio que reciba appState sea observado y actualizar la vista
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            //Accedemos a la clase de navegacion para movernos de vista según el appState que tengamos
            MainStateNavigation()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appState)
        }
    }
}


