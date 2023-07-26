//
//  LoginView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState : AppState
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                /* Aqui se debe indicar el logo final*/
                Text("WELLCONNECT")
                    .font(.largeTitle)
                    .foregroundColor(Color.orange)
                    .fontWeight(.bold)
                Spacer()
                
                TextField("Usuario", text: $viewModel.username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                
                SecureField("Contraseña", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                
                Button(action: viewModel.loginUserPrueba) {
                    Text("Entrar")
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 90)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                HStack {
                    Text("¿No tienes una cuenta?")
                    
                    Button(action: {appState.navigationState = .register}, label: {
                        Text("Registrarse")
                            .underline()
                    })
                }
                .padding(.top, 10)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("¿Olvidaste tu contraseña?")
                        .underline()
                })
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

