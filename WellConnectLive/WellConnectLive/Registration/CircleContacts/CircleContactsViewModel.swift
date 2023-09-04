//
//  CircleContacts.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 15/8/23.
//

import Foundation
import SwiftUI


class CircleOfTrustViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    var appState: AppState
    private var firestoreManager = FirestoreManager()

    init(appState: AppState) {
        self.appState = appState
    }
    
    func addOrUpdateContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            // Si el contacto ya existe--actualizar
            contacts[index] = contact
        } else {
            // Si el contacto no existe---agregar
            contacts.append(contact)
        }
    }
    
    func updateContactsAndSaveUserData() {
        guard let userId = appState.userId else {
            print("Error: userId is nil")
            return
        }

        firestoreManager.getUserData(by: userId) { userData, error in
            if let error = error {
                print("Error al obtener UserData: \(error)")
                return
            }

            guard var userData = userData else {
                print("Error: userData is nil")
                return
            }

            userData.contacts = self.contacts

            self.firestoreManager.saveUserData(userData: userData) { error in
                if let error = error {
                    print("Error al guardar UserData: \(error)")
                } else {
                    print("UserData guardado correctamente")
                }
            }
        }
    }


}

