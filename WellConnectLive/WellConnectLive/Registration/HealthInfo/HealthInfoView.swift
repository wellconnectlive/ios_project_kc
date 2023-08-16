//
//  HealthInfoView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//

import SwiftUI

struct HealthInfoView: View {
    @ObservedObject var viewModel: HealthInfoViewModel
    @State private var showAllergiesPopup = false
    @State private var otherDiseaseText: String = ""
    @State private var showOtherDiseasePopup = false
    @State private var showNextScreen = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Cuéntanos un poco sobre ti")
                    .font(.title)
                    .padding(.bottom, 20)
                trackingSection
                generalHealthSection
                allergiesSection
                otherDiseaseSection
                
                Button("Siguiente") {
                    showNextScreen = true
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .sheet(isPresented: $showOtherDiseasePopup) {
            OtherDiseasePopupView(otherDiseaseText: $otherDiseaseText)
        }
    }
        
    var trackingSection: some View {
        CardView {
            Toggle(isOn: $viewModel.allowTracking) {
                Text("Permitir seguimiento")
            }
        }
    }
    
    var generalHealthSection: some View {
        VStack(spacing: 5) {
            CardView {
                Toggle(isOn: $viewModel.discapacidadIntelectual) {
                    Text("Discapacidad Intelectual")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.diabetes) {
                    Text("Diabetes")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.hipertension) {
                    Text("Hipertensión")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.alzheimer) {
                    Text("Alzheimer")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.autismo) {
                    Text("Autismo")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.enfermedadVonWillebrand) {
                    Text("Enfermedad Von Willebrand")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.hemofilia) {
                    Text("Hemofilia")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.demenciaSenil) {
                    Text("Demencia Senil")
                }
            }
            
            CardView {
                Toggle(isOn: $viewModel.sordera) {
                    Text("Sordera")
                }
            }
        }
    }
    
    var allergiesSection: some View {
        CardView {
            HStack {
                Text("Alergias (\(viewModel.numberOfAllergies))")
                Spacer()
                Button("Seleccionar") {
                    showAllergiesPopup = true
                }
            }
        }
        .sheet(isPresented: $showAllergiesPopup) {
            AllergiesSelectionView(viewModel: viewModel)
        }
    }
    
    var otherDiseaseSection: some View {
        CardView {
            VStack(spacing: 5) {
                Text("Otras enfermedades")
                    .font(.headline)
                Button("Añadir enfermedad") {
                    showOtherDiseasePopup = true
                }
            }
        }
    }
    
    
    
    
    
    struct HealthInfoView_Previews: PreviewProvider {
        static var previews: some View {
            HealthInfoView(viewModel: HealthInfoViewModel())
        }
    }
    
    
    
}
