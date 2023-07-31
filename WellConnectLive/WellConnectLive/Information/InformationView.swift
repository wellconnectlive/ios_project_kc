//
//  InformationView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 30/7/23.
//

import SwiftUI


struct InformationView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: InformationViewModel
    
    init(appState: AppState) {
        self.viewModel = InformationViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Esto es InformationView  -- informacion basica")
                    .font(.title)
                    .padding()
                
                Button(action: viewModel.logout) {
                    Text("Cerrar sesión")
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 90)
                }
            }
        }
        
    }
}



struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(appState: AppState())
    }
}
