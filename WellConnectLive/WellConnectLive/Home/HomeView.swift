//
//  HomeView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 30/7/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: HomeViewModel
    /* necesita un inicializador porque intenta usar un objeto de un entorno que no está definido en el ViewModel.*/
    @State private var selection = 0
    
    init(appState: AppState) {
        self.viewModel = HomeViewModel(appState: appState)
    }

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            //Alex
            TabView(selection: $selection) {
                PrincipalView()
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                
                
                Text("Pantalla2")
                    .tabItem {
                        Image(systemName: "map")
                    }.tag(1)
                Text("Pantalla3")
                    .tabItem {
                        Image(systemName: "calendar.badge.plus")
                    }.tag(2)
                Text("Pantalla4")
                    .tabItem {
                        Image(systemName: "camera.fill.badge.ellipsis")
                    }.tag(3)
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appState: AppState())
    }
}


/*
ZStack{
    LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    VStack {
        Text("Bienvenido a la pantalla de inicio")
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
        Button(action: viewModel.navigateToInfoBasic) {
            Text("Ir a InfoBasicView")
                .frame(width: 200, height: 50)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top, 20)
        }
    }
}
*/
