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

    @State var showAlert = false
    @State var alertMessage = ""

    init(appState: AppState) {
        self.viewModel = VerificationEmailViewModel(appState: appState)
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TextField("Código de Verificación", text: $viewModel.verificationCode)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)

                Button(action: viewModel.sendVerificationEmail) {
                    Text("Enviar Email de Verificación")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                Button(action: viewModel.resendCode) {
                    Text("Reenviar Código")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                Button(action: viewModel.checkVerification) {
                    Text("Siguiente")
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                Button(action: { appState.navigationState = .register }) {
                    Text("Atrás")
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alerta"), message: Text(alertMessage), dismissButton: .default(Text("Entendido")))
        }
    }
}

struct VerificationEmailView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        VerificationEmailView(appState: appState).environmentObject(appState)
    }
}
