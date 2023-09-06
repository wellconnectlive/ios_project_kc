//
//  VerificationEmailView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 10/8/23.
//
import SwiftUI

struct VerificationEmailView: View {
    @ObservedObject var viewModel: VerificationEmailViewModel
    @EnvironmentObject var appState: AppState

    init(appState: AppState) {
        self.viewModel = VerificationEmailViewModel(appState: appState)
    }

    var body: some View {
        ZStack {
            
            
            VStack {
                // Flecha para ir atrás
                NavigationButton()
                // Título "Verificate your email"
                Text("Verifica tu email")
                    .font(.custom("Inter", size: 40))
                    .foregroundColor(Color.secondaryButtonColor)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)

                // Campo de texto "Código de Verificación" (comentado por si acaso)
                /*
                TextField("Código de Verificación", text: $viewModel.verificationCode)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                */
                Spacer()
                // Botón "Send verification email"
                Button(action: viewModel.sendVerificationEmail) {
                    Text("Enviar email de verificación")
                        .frame(width: 200)
                        .padding()
                        .background(Color.secondaryButtonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                // Mensaje "Check your email and verify your email, then you would continue the process"
                Text("Comprueba tu email y verifica la cuenta. Después, continua con el proceso. Muchas gracias.")
                    .font(.body)
                    .foregroundColor(Color.secondaryButtonColor)
                    .padding(.top, 20)
                    .frame(width: 250)
                
                Spacer()

                // Botón "Next"
                Button(action: viewModel.checkVerification) {
                    Text("Siguiente")
                        .frame(width: 200, height: 50)
                        .background(Color.primaryButtonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                if viewModel.isLoading {
                    ProgressView()
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Alerta"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Entendido")))
        }
    }
}

struct NavigationButtonToRegister: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack {
            Button(action: {
                appState.navigationState = .register
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.primaryButtonColor)
                    .padding()
            }
            Spacer()
        }
    }
}

struct VerificationEmailView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        VerificationEmailView(appState: appState).environmentObject(appState)
    }
}
