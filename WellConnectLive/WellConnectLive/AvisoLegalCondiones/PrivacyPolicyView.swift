//
//  PrivacyPolicyView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//


import SwiftUI
import Combine

struct PrivacyPolicyView: View {
    @Binding var isShown: Bool
    @Binding var isPrivacyAccepted: Bool
    @Binding var isDataSharingAccepted: Bool


    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Wellconnect trata sus datos personales para garantizar el buen funcionamiento de nuestra app. Sus derechos relativos al tratamiento de sus datos personales incluyen el derecho de acceder, rectificar o solicitar la eliminación de sus datos, dentro de los límites de la legislación aplicable. Nuestra política de privacidad ofrece más información acerca de sus datos personales y cómo los usamos.")
                    NavigationLink(destination: PrivacyPolicyDetailsView()) {
                        Text("Revise nuestra política de privacidad")
                    }
                    Text("La app Wellconnect funciona de conformidad con nuestros términos y condiciones.")
                    NavigationLink(destination: TermsAndConditionsView()) {
                        Text("Términos y condiciones")
                    }
                    Toggle("He leído y comprendo la política de privacidad y los términos y condiciones.", isOn: $isPrivacyAccepted)
                    Text("Puede cambiar estas preferencias en cualquier momento desde la aplicación.")
                    Toggle("Acepto que compartan mis datos personales con médicos y asociados para mejorar las características y funciones de Wellconnect.", isOn: $isDataSharingAccepted)
                    HStack {
                        Spacer()
                        Button("Cerrar") {
                            isShown = false
                        }
                        .padding()
                        .background(Color.primaryButtonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Button("Aceptar") {
                            if isPrivacyAccepted && isDataSharingAccepted {
                                isShown = false
                            } else {
                                //mostrar mensaje de alerta
                            }
                        }
                        .padding()
                        .background(Color.secondaryButtonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer()
                    }

                
                    

                }
                .padding()
            }
        }
    }
}



struct PrivacyPolicyView_Previews: PreviewProvider {
    @State static var isShown = true
    @State static var isPrivacyAccepted = false
    @State static var isDataSharingAccepted = false
    
    static var previews: some View {
        PrivacyPolicyView(isShown: $isShown, isPrivacyAccepted: $isPrivacyAccepted, isDataSharingAccepted: $isDataSharingAccepted)
    }
}


