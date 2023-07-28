//
//  TermsAndConditionsView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//

import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    Text("TÉRMINOS Y CONDICIONES")
                        .font(.title)
                        .bold()
                        
                    Text("Última actualización: 26.07.2023")
                        .font(.subheadline)
                    // Aquí es donde se agrega el texto de la política de privacidad
                    Text("La aplicación Wellconnect ('Aplicación móvil') y los servicios asociados ('Servicio' o 'Servicios') son operados por empresa...")
                }
                .padding()
            }
        }
        
    }
}


struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}
