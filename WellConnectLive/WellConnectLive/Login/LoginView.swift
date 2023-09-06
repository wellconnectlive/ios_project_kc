//
//  LoginView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState) {
        self.viewModel = LoginViewModel(appState: appState)
    }

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                ZStack {
                    Color.primaryButtonColor
                        .frame(maxHeight: UIScreen.main.bounds.height / 2.5)
                        .edgesIgnoringSafeArea([.top, .leading, .trailing])
                    
                    Image("LogoApp")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                }
                
                Text("Bienvenido")
                    .font(.custom("Inter", size: 20))
                    .foregroundColor(Color.secondaryButtonColor)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                CardView {
                    TextField("Email ", text: $viewModel.username)
                }
                
                CardView {
                    SecureField("Contraseña", text: $viewModel.password)
                }
                
                HStack {
                    Button(action: { appState.navigationState = .forgotPassword }, label: {
                        Text("¿Olvidó la contraseña?")
                            .underline()
                            .foregroundColor(Color.secondaryButtonColor)
                            .padding(.leading)
                    })
                    Spacer()
                }
                
                Button(action: viewModel.loginUser) {
                    Text("Iniciar")
                        .frame(maxWidth: 320)
                        .frame(height: 50)
                        .background(Color.primaryButtonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                if viewModel.isLoading {
                    ProgressView()
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }

                HStack(spacing: 5) {
                    Text("¿No eres miembro?")
                        .foregroundColor(Color.black)
                        
                    Button(action: { appState.navigationState = .register }, label: {
                        Text("Regístrate ahora")
                            .underline()
                            .foregroundColor(Color.primaryButtonColor)
                            .bold()
                    })
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return LoginView(appState: appState).environmentObject(appState)
    }
}


