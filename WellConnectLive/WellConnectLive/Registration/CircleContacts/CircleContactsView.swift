//
//  CircleContactsView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 15/8/23.
//

import SwiftUI

struct CircleContactsView: View {
    @ObservedObject var viewModel: CircleOfTrustViewModel
    @EnvironmentObject var appState: AppState
    @State private var showAddContactPopup = false
    @State private var contactToEdit: Contact? = nil
    
    init(appState: AppState) {
        self.viewModel = CircleOfTrustViewModel(appState: appState)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Círculo de Confianza")
                .font(.largeTitle)

            Text("Añade a las personas de confianza que quiras tener como contactos.")

            List {
                ForEach(viewModel.contacts) { contact in
                    CardView {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Text(contact.compartirUbicacion ?? false ? "Tracking Activado" : "Tracking Desactivado")
                                .foregroundColor(contact.compartirUbicacion ?? false ? .green : .red)
                        }
                    }
                    .onTapGesture {
                        contactToEdit = contact
                        showAddContactPopup.toggle()
                    }
                }
            }

            Button(action: {
                contactToEdit = nil // Asegurarnos de que no esté editando ningún contacto cuando añade uno nuevo
                showAddContactPopup.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }

            Button("Finalizar Registro") {
                viewModel.updateContactsAndSaveUserData()
                DispatchQueue.main.async {
                    appState.navigationState = .home
                }
            }
            .padding()


}
        .sheet(isPresented: $showAddContactPopup) {
            if let contact = contactToEdit {
                AddContactPopup(contact: contact, isPresented: $showAddContactPopup, viewModel: viewModel) // Pasamos el contacto a editar
            } else {
                AddContactPopup(isPresented: $showAddContactPopup, viewModel: viewModel)
            }
        }
    }
}


struct CircleContactsView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return CircleContactsView(appState: appState).environmentObject(appState)
    }
}

