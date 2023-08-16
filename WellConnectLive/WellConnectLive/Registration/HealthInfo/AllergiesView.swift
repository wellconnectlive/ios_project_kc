//
//  AllergiesView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//
import Foundation
import SwiftUI

struct AllergiesSelectionView: View {
    @ObservedObject var viewModel: HealthInfoViewModel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationView {
            Form {
                Group {
                    Section(header: Text("Medicamentos")) {
                        ForEach(AllergyMedicamentos.allCases, id: \.self) { allergy in
                            Toggle(allergy.rawValue, isOn: .init(
                                get: { self.viewModel.allergiesMedicamentos.contains(allergy) },
                                set: { adding in
                                    if adding {
                                        self.viewModel.allergiesMedicamentos.append(allergy)
                                    } else {
                                        self.viewModel.allergiesMedicamentos.removeAll { $0 == allergy }
                                    }
                                }
                            ))
                        }
                    }
                    
                    Section(header: Text("Alimentación")) {
                        ForEach(AllergyAlimentacion.allCases, id: \.self) { allergy in
                            Toggle(allergy.rawValue, isOn: .init(
                                get: { self.viewModel.allergiesAlimentacion.contains(allergy) },
                                set: { adding in
                                    if adding {
                                        self.viewModel.allergiesAlimentacion.append(allergy)
                                    } else {
                                        self.viewModel.allergiesAlimentacion.removeAll { $0 == allergy }
                                    }
                                }
                            ))
                        }
                    }
                    
                    Section(header: Text("Otros")) {
                        ForEach(AllergyOtros.allCases, id: \.self) { allergy in
                            Toggle(allergy.rawValue, isOn: .init(
                                get: { self.viewModel.allergiesOtros.contains(allergy) },
                                set: { adding in
                                    if adding {
                                        self.viewModel.allergiesOtros.append(allergy)
                                    } else {
                                        self.viewModel.allergiesOtros.removeAll { $0 == allergy }
                                    }
                                }
                            ))
                        }
                    }
                    
                    Button("OK") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarTitle("Seleccionar Alergias", displayMode: .inline)
        }
    }
}


