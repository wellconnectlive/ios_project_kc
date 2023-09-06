//
//  ProfileInformation.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 12/8/23.
//
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var appState: AppState
    @State private var showingImagePicker = false
    @State private var image: UIImage?
    
    init(appState: AppState) {
        self.viewModel = ProfileViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
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
                    
                    RegisterProgressView(currentStep: .profileInfo)
                                        .frame(width: 350, height: 60)
                                        .padding()
                    
                    Text("Vamos a crear tu perfil.")
                        .font(.custom("Inter", size: 40))
                        .foregroundColor(Color.secondaryButtonColor)
                        .padding(.leading, 20)


                    
                    Text("Necesitamos tus datos para poder crear un perfil más completo posible.")
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryButtonColor)
                        .padding(.leading, 20)

                }
                .padding(.top, 10)
                VStack(spacing: 10) {
                    basicInfoSection
                    advancedInfoSection
                    photoSection
                    saveButtonSection
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(isShown: $showingImagePicker, image: $image)
        }
    }
    
    private var basicInfoSection: some View {
        VStack(spacing: 10) {
            CardView {
                TextField("Nombre", text: $viewModel.name)
            }
            CardView {
                TextField("Apellido Paterno", text: $viewModel.apellidoPaterno)
            }
            CardView {
                TextField("Apellido Materno", text: $viewModel.apellidoMaterno)
            }
            CardView {
                TextField("DNI", text: $viewModel.dni)
            }
            CardView {
                TextField("Dirección", text: $viewModel.direccion)
            }
            CardView {
                TextField("Población", text: $viewModel.poblacion)
            }
            CardView {
                TextField("País", text: $viewModel.pais)
            }
            CardView {
                TextField("Número de Teléfono", text: $viewModel.phoneNumber)
            }
        }
    }
    
    private var advancedInfoSection: some View {
        VStack(spacing: 10) {
            CardView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Género")
                        .font(.headline)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 45) // Defina un alto para el rectángulo
                        .overlay(
                            Picker("", selection: $viewModel.genero) {
                                ForEach(Gender.allCases, id: \.self) { gender in
                                    Text(gender.rawValue).tag(gender)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        )
                }
            }

            CardView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Tipo de Sangre")
                        .font(.headline)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                        .overlay(
                            Picker("", selection: $viewModel.bloodType) {
                                ForEach(BloodType.allCases, id: \.self) { bloodType in
                                    Text(bloodType.rawValue).tag(bloodType)
                                }
                            }
                        )
                }
            }

            CardView {
                DatePicker("Fecha de Nacimiento", selection: $viewModel.fechaNacimiento, displayedComponents: .date)
            }
            
            CardView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Religión")
                        .font(.headline)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                        .overlay(
                            Picker("", selection: $viewModel.religion) {
                                ForEach(Religion.allCases, id: \.self) { religion in
                                    Text(religion.rawValue).tag(religion)
                                }
                            }
                        )
                }
            }

            CardView {
                VStack {
                    TextField("Edad", text: $viewModel.edad)
                        .keyboardType(.numberPad)
                }
            }
            
            CardView {
                VStack {
                    TextField("Código Postal", text: $viewModel.codigoPostal)
                        .keyboardType(.numberPad)
                }
            }

            CardView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Implantes")
                        .font(.headline)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                        .overlay(
                            Picker("", selection: $viewModel.selectedImplant) {
                                ForEach(viewModel.implants, id: \.self) { implant in
                                    Text(implant.rawValue).tag(implant)
                                }
                            }
                        )
                }
            }
        }
    }


    private var photoSection: some View {
        CardView {
            VStack(alignment: .leading, spacing: 5) {
                Text("Foto de Perfil")
                    .font(.headline)
                HStack {
                    if let img = image {
                        Image(uiImage: img)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: { showingImagePicker = true }) {
                        Text("Subir Foto")
                            .padding(.trailing, 100)//para centrarlo a mano
                        
                    }
                    .padding()
                }
            }
        }
    }

    private var saveButtonSection: some View {
        Button(action: viewModel.saveUserProfile) {
            Text("Siguiente")
                .frame(width: 200, height: 50)
                .background(Color.primaryButtonColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.top, 20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return ProfileView(appState: appState).environmentObject(appState)
    }
}








///SIN FORMATO "FORM"
/*
 
 import SwiftUI

 struct UserRegisterView: View {
     @State private var name: String = ""
     @State private var apellidoPaterno: String = ""
     @State private var apellidoMaterno: String = ""
     @State private var genero: Gender = .male
     @State private var dni: String = ""
     @State private var direccion: String = ""
     @State private var poblacion: String = ""
     @State private var pais: String = ""
     @State private var bloodType: BloodType = .Aplus
     @State private var fechaNacimiento: Date = Date()
     
     var body: some View {
         ZStack {
             LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                 .edgesIgnoringSafeArea(.all)
             
             ScrollView {
                 VStack {
                     
                     TextField("Nombre", text: $name)
                         .textFieldStyle()
                     
                     TextField("Apellido Paterno", text: $apellidoPaterno)
                         .textFieldStyle()
                     
                     TextField("Apellido Materno", text: $apellidoMaterno)
                         .textFieldStyle()
                     
                     Picker("Género", selection: $genero) {
                         ForEach(Gender.allCases, id: \.self) { gender in
                             Text(gender.rawValue.capitalized).tag(gender)
                         }
                     }
                     .pickerStyle(MenuPickerStyle())
                     .padding(.top, 10)
                     
                     TextField("DNI", text: $dni)
                         .textFieldStyle()
                     
                     TextField("Población", text: $poblacion)
                         .textFieldStyle()
                     
                     Picker("Tipo de Sangre", selection: $bloodType) {
                         ForEach(BloodType.allCases, id: \.self) { type in
                             Text(type.rawValue).tag(type)
                         }
                     }
                     .pickerStyle(MenuPickerStyle())
                     .padding(.top, 10)
                     
                     DatePicker("Fecha de Nacimiento", selection: $fechaNacimiento, in: Date.distantPast...Date.distantFuture, displayedComponents: .date)
                         .padding(.top, 10)
                     
                     Spacer()
                     Button("Siguiente") {
                         // Guarda la información del usuario en Coredata
                         //Navegar
                     }
                     .buttonStyle()
                     .padding(.top, 20)
                     
                 }
                 .padding()
             }
         }
     }
 }
 /* para no repetir codigo*/
 extension View {
     func textFieldStyle() -> some View {
         self
             .padding()
             .background(Color.gray.opacity(0.2))
             .cornerRadius(10)
             .padding(.top, 10)
     }
     
     func buttonStyle() -> some View {
         self
             .frame(width: 200, height: 50)
             .background(Color.orange)
             .foregroundColor(.white)
             .cornerRadius(10)
     }
 }

 struct UserRegisterView_Previews: PreviewProvider {
     static var previews: some View {
         UserRegisterView()
     }
 }

 */
