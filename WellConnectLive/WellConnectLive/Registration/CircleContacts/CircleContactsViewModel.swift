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
    
    func addOrUpdateContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            // Si el contacto ya existe--actualizar
            contacts[index] = contact
        } else {
            // Si el contacto no existe---agregar
            contacts.append(contact)
        }
    }

}

