//
//  PrivacyPolicyDetailsView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//


import SwiftUI

struct PrivacyPolicyDetailsView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("AVISO DE PRIVACIDAD")
                        .font(.title)
                        .bold()
                    Text("Última actualización: 26.07.2023")
                        .font(.subheadline)
                    // Aquí es donde se agrega el texto de la política de privacidad
                    Text("Este Aviso de privacidad explica cómo se recopilan y procesan sus datos personales, incluidos los datos confidenciales...")
                }
                .padding()
            }
        }
        
    }
}


struct PrivacyPolicyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyDetailsView()
    }
}
