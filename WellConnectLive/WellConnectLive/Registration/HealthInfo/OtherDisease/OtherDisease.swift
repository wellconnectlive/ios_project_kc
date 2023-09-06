//
//  OtherDisease.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//
import Foundation
import SwiftUI

struct OtherDiseasePopupView: View {
    @StateObject var viewModel = OtherDiseasePopupViewModel()
    @Binding var otherDiseaseText: String
    @State private var diseases: [String] = []
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var isEditing = false // Variable de "estado" para el modo de edición
    var onDiseaseAdded: (String) -> Void
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Añade enfermedad")
                .font(.custom("Inter", size: 30))
                .foregroundColor(Color.secondaryButtonColor)
                .padding(.top, 50)

            CardView{
                TextField("Añadir enfermedad", text: $otherDiseaseText)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    //.padding()
                
            }
            
            Spacer()
            Button(action: {
                if let errors = viewModel.isDiseaseValid(otherDiseaseText) {
                    alertMessage = errors.joined(separator: "\n")
                    showAlert = true
                    otherDiseaseText = ""
                } else {
                    // Notificar al padre que la enfermedad ha sido añadida
                    onDiseaseAdded(otherDiseaseText)
                    
                    alertMessage = "La enfermedad \(otherDiseaseText) se ha añadido correctamente."
                    showAlert = true
                    otherDiseaseText = ""
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
            }

            Button(action: {
                isEditing.toggle()
            }) {
                Text(isEditing ? "Hecho" : "Editar")
            }
            .padding(.bottom, 10)

            List {
                ForEach(diseases, id: \.self) { disease in
                    Text(disease)
                }
                .onDelete(perform: removeDiseases)
            }
            .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive)) // Activar el modo de edición

            Button("OK") {
                // Guarda las enfermedades etc.
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Información"), message: Text(alertMessage), dismissButton: .default(Text("Aceptar")))
        }
    }
    
    func removeDiseases(at offsets: IndexSet) {
        diseases.remove(atOffsets: offsets)
    }
}
