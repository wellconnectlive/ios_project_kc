//
//  WellConnectLiveApp.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct wellnesstrackApp: App {
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
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


