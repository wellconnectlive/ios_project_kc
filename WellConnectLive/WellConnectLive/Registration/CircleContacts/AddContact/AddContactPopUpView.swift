//
//  AddContactPopUpView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 15/8/23.
//

import Foundation
import SwiftUI

struct AddContactPopup: View {
    @Binding var isPresented: Bool
    @State private var newContact: Contact
    @ObservedObject var viewModel: CircleOfTrustViewModel
    @ObservedObject var popupViewModel = AddContactPopupViewModel()//se instancia que cada vez llamamos a addcontactpoppup(unon nuevo), como solo tiene validadores no hay problema, pero si en futuro añdimos estados que necesiten ser compartidos entre diferntes instancias deberiamos dejarlo asi:     @ObservedObject var popupViewModel: AddContactPopupViewModel e indicarlos en iniciadores

    // Inicializador para editar un contacto existente
    init(contact: Contact, isPresented: Binding<Bool>, viewModel: CircleOfTrustViewModel) {
        _isPresented = isPresented
        _newContact = State(initialValue: contact)
        self.viewModel = viewModel
    }
    
    // Inicializador para añadir un nuevo contacto
    init(isPresented: Binding<Bool>, viewModel: CircleOfTrustViewModel) {
        _isPresented = isPresented
        _newContact = State(initialValue: Contact(id: UUID().uuidString, name: "", parentesco: nil, email: nil, phoneNumber: nil, direccion: nil, compartirUbicacion: nil))
        self.viewModel = viewModel
    }
    
    
    private var emailContact: Binding<String> {
        Binding<String>(
            // Esta función 'get' se encarga de obtener el valor actual del email del contacto.
            // Si 'newContact.email' es nil (es decir, si no tiene un valor), se devuelve una cadena vacía ("").
            get: { newContact.email ?? "" },

            // Esta función 'set' se encarga de establecer el valor del email del contacto.
            // Si el valor proporcionado ($0, que es un argumento predeterminado para la primera entrada en una función de cierre)
            // es una cadena vacía, entonces 'newContact.email' se establece en nil.
            // De lo contrario, 'newContact.email' se establece en el valor proporcionado.
            set: { newContact.email = $0.isEmpty ? nil : $0 }
        )
    }


    private var phoneNumberContact: Binding<String> {
        Binding<String>(
            get: { newContact.phoneNumber ?? "" },
            set: { newContact.phoneNumber = $0.isEmpty ? nil : $0 }
        )
    }

    private var direccionContact: Binding<String> {
        Binding<String>(
            get: { newContact.direccion ?? "" },
            set: { newContact.direccion = $0.isEmpty ? nil : $0 }
        )
    }
    
    private var compartirUbicacionContact: Binding<Bool> {
        Binding<Bool>(
            get: { newContact.compartirUbicacion ?? false },
            set: { newContact.compartirUbicacion = $0 }
        )
    }

    
    var body: some View {
        VStack(spacing: 20) {

            CardView {
                TextField("Nombre", text: $newContact.name)
                    .textFieldStyle()
            }

            CardView {
                Picker("Parentesco", selection: $newContact.parentesco) {
                    ForEach(Parentesco.allCases, id: \.self) { parentesco in
                        Text(parentesco.rawValue.capitalized).tag(parentesco)
                    }
                }
            }

            CardView {
                TextField("Email", text: emailContact)
                    .textFieldStyle()
            }

            CardView {
                TextField("Número de Teléfono", text: phoneNumberContact)
                    .textFieldStyle()
            }

            CardView {
                TextField("Dirección", text: direccionContact)
                    .textFieldStyle()
            }

            CardView {
                Toggle("Compartir Ubicación", isOn: compartirUbicacionContact)
            }

            Button("OK") {
                let email = newContact.email ?? ""
                let phoneNumber = newContact.phoneNumber ?? ""
                if popupViewModel.areValidFields(name: newContact.name, email: email, phoneNumber: phoneNumber) {
                    viewModel.addOrUpdateContact(newContact)
                    viewModel.updateContactsAndSaveUserData()
                    isPresented = false
                } else {
                    // Mostrar un mensaje de error
                }
            }
            .buttonStyle()
            .padding(.top, 10)

        }
        .padding()
    }
}

