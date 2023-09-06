//
//  HealthInfoView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//
import SwiftUI

struct HealthInfoView: View {
    @ObservedObject var viewModel: HealthInfoViewModel
    @EnvironmentObject var appState: AppState
    @State private var showAllergiesPopup = false
    @State private var otherDiseaseText: String = ""
    @State private var showOtherDiseasePopup = false
    @State private var showNextScreen = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(action: {
                            appState.navigationState = .profile // Cambia esto al estado de navegación que desees
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(Color.primaryButtonColor)
                                .padding()
                        }
                        Spacer()
                    }
                    
                    RegisterProgressView(currentStep: .healthInfo)
                        .frame(width: 350, height: 60)
                        .padding()

                    
                    Text("Cuéntanos un poco sobre ti")
                        .font(.custom("Inter", size: 40))
                        .foregroundColor(Color.secondaryButtonColor)
                        .padding(.leading, 20)
                    Text("Selecciona la situación que más se ajuste a ti")
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryButtonColor)
                        .padding(.leading, 20)

                }
                .padding(.top, 10)
                VStack(spacing: 10) {
                    trackingSection
                    generalHealthSection
                    allergiesSection
                    otherDiseaseSection
                    nextButtonSection
                }
                .padding()
            }
        }
        .sheet(isPresented: $showOtherDiseasePopup) {
            OtherDiseasePopupView(otherDiseaseText: $otherDiseaseText) { addedDisease in
                let diseaseModel = Disease(type: .other, name: addedDisease)
                viewModel.diseases.append(diseaseModel)
            }
        }
    }
    
    var trackingSection: some View {
        CardView {
            Toggle(isOn: Binding<Bool>(
                get: { self.viewModel.userData.allowTracking ?? false },
                set: { self.viewModel.userData.allowTracking = $0 }
            )) {
                Text("Permitir seguimiento")
            }
        }
    }
    
    var generalHealthSection: some View {
        VStack(spacing: 5) {
            ForEach(Disease.DiseaseType.allCases, id: \.self) { diseaseType in
                CardView {
                    Toggle(isOn: Binding(get: {
                        return self.viewModel.diseases.contains(where: { $0.type == diseaseType })
                    }, set: { (newValue) in
                        if newValue {
                            self.viewModel.diseases.append(Disease(type: diseaseType))
                        } else {
                            self.viewModel.diseases.removeAll(where: { $0.type == diseaseType })
                        }
                    })) {
                        Text(diseaseType.rawValue.capitalized)
                    }
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
            VStack(alignment: .leading, spacing: 15) {
                Text("Otras enfermedades")
                    .font(.headline)
                
               

                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 45)
                    .overlay(
                        Button("Añadir enfermedad") {
                            showOtherDiseasePopup = true
                        }
                        
                        .padding()
                        .foregroundColor(Color.primaryButtonColor)
                    )
            }
        }
    }


    private var nextButtonSection: some View {
        Button(action: {
            viewModel.saveHealthInfo()
            showNextScreen = true
        }) {
            Text("Siguiente")
                .frame(width: 200, height: 50)
                .background(Color.primaryButtonColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.top, 20)
    }
}

struct HealthInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return HealthInfoView(viewModel: HealthInfoViewModel(appState: appState)).environmentObject(appState)
    }
}
