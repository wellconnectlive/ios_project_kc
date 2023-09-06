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
            contacts[index] = contact
        } else {
            contacts.append(contact)
        }
    }

    func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
        // Opcionalmente, puedes llamar a updateContactsAndSaveUserData() aquí para guardar cambios de inmediato
    }

    func updateContactsAndSaveUserData() {
        guard let userId = appState.userId else {
            print("Error: userId is nil")
            return
        }

        firestoreManager.updateContactsForUser(with: userId, contacts: contacts) { error in
            if let error = error {
                print("Error al actualizar contactos en Firestore:", error.localizedDescription)
            } else {
                print("Contactos actualizados con éxito en Firestore.")
            }
        }
    }
    func deleteContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
    }
}
