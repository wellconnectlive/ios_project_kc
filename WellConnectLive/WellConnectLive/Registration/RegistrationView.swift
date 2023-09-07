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
    @State var showingTermsAlert = false
    
    init(appState: AppState) {
        self.viewModel = RegistrationViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                NavigationButton()
                TitleSection()
                    
                Spacer()
                InputSection(viewModel: viewModel)
                ActionsSection(viewModel: viewModel, showingTermsAlert: $showingTermsAlert)
                Spacer()
            }
            .padding()
        }
    }
}

struct NavigationButton: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack {
            Button(action: {
                appState.navigationState = .login
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.primaryButtonColor)
                    .padding()
            }
            Spacer()
        }
    }
}

struct TitleSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sign up")
                .font(.custom("Inter", size: 40))
                .foregroundColor(Color.secondaryButtonColor)
                .fontWeight(.bold)
            
            Text("Create an account to get started")
                .font(.custom("Inter", size: 14))
                .foregroundColor(Color.secondaryButtonColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Ajustar alineación a la izquierda
    }
}

struct InputSection: View {
    @ObservedObject var viewModel: RegistrationViewModel

    var body: some View {
        Group {
            TextEntry(title: "Email Address", placeholder: "Email", text: $viewModel.email)
            SecureTextEntry(title: "Password", placeholder: "Create Password", text: $viewModel.password)
            SecureTextEntry(title: "", placeholder: "Confirm Password", text: $viewModel.repeatPassword)
        }
    }
}

struct TextEntry: View {
    var title: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Inter", size: 16))
                .foregroundColor(Color.secondaryButtonColor)
                .fontWeight(.bold)
            CardView {
                TextField(placeholder, text: $text)
                    
            }
        }
    }
}

struct SecureTextEntry: View {
    var title: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Inter", size: 16))
                .foregroundColor(Color.secondaryButtonColor)
                .fontWeight(.bold)
            CardView {
                SecureField(placeholder, text: $text)
                    
            }
        }
    }
}

struct ActionsSection: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @Binding var showingTermsAlert: Bool

    var body: some View {
        Group {
            TermsButton(showingTermsAlert: $showingTermsAlert,
                        isPrivacyAccepted: $viewModel.isPrivacyAccepted,
                        isDataSharingAccepted: $viewModel.isDataSharingAccepted)
            RegisterButton(action: viewModel.registerUser)
        }
    }
}


struct TermsButton: View {
    @Binding var showingTermsAlert: Bool
    @Binding var isPrivacyAccepted: Bool
    @Binding var isDataSharingAccepted: Bool

    var body: some View {
        Button(action: { showingTermsAlert = true }) {
            Text("Terms and Conditions and the Privacy Policy")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.clear)
                .foregroundColor(Color.secondaryButtonColor)
                .font(.caption)
                .fontWeight(.bold)
        }
        .sheet(isPresented: $showingTermsAlert) {
            PrivacyPolicyView(isShown: $showingTermsAlert,
                              isPrivacyAccepted: $isPrivacyAccepted,
                              isDataSharingAccepted: $isDataSharingAccepted)
        }

        
        
        
    }
}



struct RegisterButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Sign up")
                .frame(minWidth: 250, maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.primaryButtonColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top, 10)
                
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        RegistrationView(appState: appState).environmentObject(appState)
    }
}

/*
struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @EnvironmentObject var appState: AppState
    @State var showingTermsAlert = false
    
    init(appState: AppState) {
        self.viewModel = RegistrationViewModel(appState: appState)
    }
    
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

                Group {
                    Text("Sign up")
                        .font(.custom("Inter", size: 24))
                        .foregroundColor(Color.secondaryButtonColor)
                        .fontWeight(.bold)
                    
                    Text("Create an account")
                        .font(.custom("Inter", size: 14))
                        .foregroundColor(Color.secondaryButtonColor)

                    Text("Email Address")
                        .font(.custom("Inter", size: 16))
                        .foregroundColor(Color.secondaryButtonColor)
                        .fontWeight(.bold)
                    CardView {
                        TextField("Email", text: $viewModel.email)
                            
                    }
                }

                Group {
                    Text("Password")
                        .font(.custom("Inter", size: 16))
                        .foregroundColor(Color.secondaryButtonColor)
                        .fontWeight(.bold)
                    CardView {
                        SecureField("Create Password", text: $viewModel.password)
                            
                    }

                    Text("Confirm Password")
                        .font(.custom("Inter", size: 16))
                        .foregroundColor(Color.secondaryButtonColor)
                        .fontWeight(.bold)
                    CardView {
                        SecureField("Confirm Password", text: $viewModel.repeatPassword)
                            
                    }
                }

                Group {
                    Button(action: { showingTermsAlert = true }) {
                        Text("Aceptar Términos y Condiciones")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(.blue)
                            .font(.caption)
                    }
                    .sheet(isPresented: $showingTermsAlert) {
                        PrivacyPolicyView(isShown: $showingTermsAlert, isPrivacyAccepted: $viewModel.isPrivacyAccepted, isDataSharingAccepted: $viewModel.isDataSharingAccepted)
                    }

                    Button(action: viewModel.registerUser) {
                        Text("Sign up")
                            .frame(width: 200, height: 50)
                            .background(Color.primaryButtonColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }
                }
                
                Spacer()
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


*/
