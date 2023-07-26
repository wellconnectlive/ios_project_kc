//
//  RegistrationView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                
                Text("Ingresa tu información personal")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
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
                DatePicker("Fecha de nacimiento", selection: $viewModel.birthDate, displayedComponents: .date)
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
                
                Group {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }

                    Button(action: viewModel.registerUser) {
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
        RegistrationView()
    }
}
    
