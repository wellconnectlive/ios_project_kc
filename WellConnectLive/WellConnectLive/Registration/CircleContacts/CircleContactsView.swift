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
            
            // Flecha de navegación
            Button(action: {
                appState.navigationState = .information
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding(.leading, 20) // Añade padding a la izquierda para la flecha
                    .frame(maxWidth: .infinity, alignment: .leading) // Flecha alineada a la izquierda
            }
            
            RegisterProgressView(currentStep: .circleOfTrust)
                .frame(width: 300, height: 60)
                .padding()

            
            // Título "Círculo de Confianza"
            Text("Círculo de Confianza")
                .font(.custom("Inter", size: 40))
                .foregroundColor(Color.secondaryButtonColor)
                .lineLimit(nil) // Permite que el texto se expanda en múltiples líneas
                .padding(.leading, 20)
                .frame(maxWidth: 600, alignment: .leading) // Permite que el Text se expanda verticalmente si es necesario

            // Subheadline
            Text("Añade a las personas de confianza que quiras tener como contactos.")
                .font(.subheadline)
                .foregroundColor(Color.secondaryButtonColor)
                .lineLimit(nil) // Permite que el texto se expanda en múltiples líneas
                .padding(.leading, 20)
                .frame(maxWidth: 600, alignment: .leading) // Permite que el Text se expanda verticalmente si es necesario

            // Lista de contactos
            List {
                            ForEach(viewModel.contacts) { contact in
                                HStack {
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
                                    
                                    Button(action: {
                                        viewModel.deleteContact(contact)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    .padding(.leading, 8)
                                }
                            }
                        }

            // Botón para añadir contacto
            Button(action: {
                contactToEdit = nil // Asegurarnos de que no esté editando ningún contacto cuando añade uno nuevo
                showAddContactPopup.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }

            // Botón de finalización
            Button("Finalizar Registro") {
                viewModel.updateContactsAndSaveUserData()
                DispatchQueue.main.async {
                    appState.navigationState = .home
                }
            }
            .frame(width: 200, height: 50)
            .background(Color.primaryButtonColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .sheet(isPresented: $showAddContactPopup) {
            if let contact = contactToEdit {
                AddContactPopup(contact: contact, isPresented: $showAddContactPopup, viewModel: viewModel)
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


