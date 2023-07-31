//
//  RegistrationView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @EnvironmentObject var appState: AppState
    @State var showingTermsAlert = false // Se usa para controlar la visualización del mensaje emergente del aviso legal y condiciones
    
    init(appState: AppState) {
        self.viewModel = RegistrationViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                
                TextField("Nombre", text: $viewModel.firstName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                
                TextField("Primer apellido", text: $viewModel.lastName1)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                TextField("Segundo apellido", text: $viewModel.lastName2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                
                TextField("DNI", text: $viewModel.dni)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                DatePicker("Fecha de nacimiento", selection: $viewModel.fechaInscripcion, displayedComponents: .date)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                SecureField("Contraseña", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                SecureField("Repetir contraseña", text: $viewModel.repeatPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top, 10)
                
                Button(action: { showingTermsAlert = true }) {
                            Text("Aceptar Términos y Condiciones")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.clear)
                                .foregroundColor(.blue)
                                .font(.caption)
                        }.sheet(isPresented: $showingTermsAlert) {
                            PrivacyPolicyView(isShown: $showingTermsAlert)
                        }
                
                Group {
                    Button(action: {
                        viewModel.registerUser()
                        if viewModel.errorMessage.isEmpty {
                            print("Usuario registrado exitosamente!")
                        } else {
                            print(viewModel.errorMessage)
                        }
                    }) {
                        Text("Registrar")
                            .frame(width: 200, height: 50)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }

                }

            }
            .padding()
        }
    }
}
    
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
            let appState = AppState() 
            RegistrationView(appState: appState).environmentObject(appState)
        }
}
    
