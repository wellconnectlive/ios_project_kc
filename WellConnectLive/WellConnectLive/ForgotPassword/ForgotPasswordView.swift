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
                LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Recuperar contraseña")
                        .font(.largeTitle)
                        .foregroundColor(Color.orange)
                        .fontWeight(.bold)
                    Spacer()
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.top, 10)

                    if let error = viewModel.error {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    //si el campo email est´vacio estara gris y si se rellena naranja y se podrá enviar
                    /* falta añadir verificador de email ya creado en login y */
                    Button(action: viewModel.sendPasswordReset) {
                        Text("Enviar email de restablecimiento de contraseña")
                            .frame(width: 200, height: 50)
                            .background(viewModel.email.isEmpty ? Color.gray : Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 90)
                    }
                    .disabled(viewModel.email.isEmpty)

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


