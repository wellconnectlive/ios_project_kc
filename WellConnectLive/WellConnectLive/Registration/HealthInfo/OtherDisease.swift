//
//  OtherDisease.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//

import Foundation
import SwiftUI

struct OtherDiseasePopupView: View {
    @Binding var otherDiseaseText: String
    @State private var diseases: [String] = []
    @State private var showAlert = false
    @State private var addedDisease = ""
    @State private var isEditing = false // Variable de estado para el modo de edición
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Añade enfermedad")
                .font(.headline)
                .padding(.top, 10)

            TextField("Añadir enfermedad", text: $otherDiseaseText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if !otherDiseaseText.isEmpty {
                    diseases.append(otherDiseaseText)
                    addedDisease = otherDiseaseText
                    otherDiseaseText = ""
                    showAlert = true
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
            }

            // Botón Editar
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
                // Cierra el popup:
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Enfermedad añadida"), message: Text("La enfermedad \(addedDisease) se ha subido correctamente."), dismissButton: .default(Text("Aceptar")))
        }
    }
    
    func removeDiseases(at offsets: IndexSet) {
        diseases.remove(atOffsets: offsets)
    }
}
