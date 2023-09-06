//
//  ForgotPasswordView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 31/7/23.
//
import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        // Navegar de regreso al login
                        appState.navigationState = .login
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color.primaryButtonColor)
                            .padding()
                    }
                    Spacer()
                }

                Spacer(minLength: 40) // Espaciado para centrar el título un poco más abajo

                Text("Cambiar la contraseña")
                    .font(.custom("Inter", size: 50))
                    .foregroundColor(Color.secondaryButtonColor)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()

                CardView {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        /*.overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )*/
                }
                .padding(.top, 40)

                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                }

                Button(action: viewModel.sendPasswordReset) {
                    Text("Enviar email")
                        .frame(width: 200, height: 50)
                        .background(viewModel.email.isEmpty ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.email.isEmpty)
                .padding(.top, 30)

                if viewModel.passwordResetSent {
                    Text("¡Email de restablecimiento de contraseña enviado!")
                        .foregroundColor(.green)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView().environmentObject(AppState())
    }
}


