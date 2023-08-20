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
            //ya que lo tenemos como opcional; podemos usar guard o if let, pero para un toggle no es la forma mas directa o recomendable, segun youtube
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
            VStack(spacing: 5) {
                Text("Otras enfermedades")
                    .font(.headline)
                Button("Añadir enfermedad") {
                    showOtherDiseasePopup = true
                }
            }
        }
    }
}


struct HealthInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HealthInfoView(viewModel: HealthInfoViewModel()) 
    }
}
