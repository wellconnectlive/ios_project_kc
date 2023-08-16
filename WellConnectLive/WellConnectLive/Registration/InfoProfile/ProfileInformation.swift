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
            
            //LinearGradient(gradient: Gradient(colors: [Color(red: 0/255, green: 209/255, blue: 255/255), Color.white]), startPoint: .top, endPoint: .bottom)
                //.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Text("Vamos a crear tu perfil.")
                    .font(.headline)
                    .padding(.top, 10)
                    .foregroundColor(Color.blue)//temporal 
                VStack(spacing: 10) {
                    /* debo separarlos sino no entran todos, un VStack y scroll esta limitado con 10 carcters*/
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
        CardView{
            VStack(spacing: 5) {
                TextField("Nombre", text: $viewModel.name)
                    .textFieldStyle()
                TextField("Apellido Paterno", text: $viewModel.apellidoPaterno)
                    .textFieldStyle()
                TextField("Apellido Materno", text: $viewModel.apellidoMaterno)
                    .textFieldStyle()
                TextField("DNI", text: $viewModel.dni)
                    .textFieldStyle()
                TextField("Dirección", text: $viewModel.direccion)
                    .textFieldStyle()
                TextField("Población", text: $viewModel.poblacion)
                    .textFieldStyle()
                TextField("País", text: $viewModel.pais)
                    .textFieldStyle()
                TextField("Número de Teléfono", text: $viewModel.phoneNumber)
                    .textFieldStyle()
            }
        }
    }
    
    private var advancedInfoSection: some View {
        VStack(spacing: 5) {
            
            CardView {
                VStack(spacing: 10) {
                    Text("Género")
                        .font(.headline)
                    Picker("Género", selection: $viewModel.genero) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }

            CardView {
                VStack(spacing: 10) {
                    Text("Tipo de Sangre")
                        .font(.headline)
                    Picker("Tipo de Sangre", selection: $viewModel.bloodType) {
                        ForEach(BloodType.allCases, id: \.self) { bloodType in
                            Text(bloodType.rawValue).tag(bloodType)
                        }
                    }
                    .frame(maxWidth : .infinity)
                }
            }

            CardView {
                DatePicker("Fecha de Nacimiento", selection: $viewModel.fechaNacimiento, displayedComponents: .date)
            }
            
            CardView {
                VStack(spacing: 10) {
                    Text("Religión")
                        .font(.headline)
                    Picker("Religión", selection: $viewModel.religion) {
                        ForEach(Religion.allCases, id: \.self) { religion in
                            Text(religion.rawValue).tag(religion)
                        }
                    }
                    .frame(maxWidth : .infinity)
                }
            }

            CardView {
                VStack {
                    TextField("Edad", text: $viewModel.edad)
                        .keyboardType(.numberPad)
                    TextField("Código Postal", text: $viewModel.codigoPostal)
                        .keyboardType(.numberPad)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }

            CardView {
                VStack(spacing: 10) {
                    Text("Implantes")
                        .font(.headline)
                    Picker("Implantes", selection: $viewModel.selectedImplant) {
                        ForEach(viewModel.implants, id: \.self) { implant in
                            Text(implant.rawValue).tag(implant)
                        }
                    }
                    .frame(maxWidth : .infinity)
                }
            }

        }
    }

    private var photoSection: some View {
        CardView {
            VStack(spacing: 5) {
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
                    }
                    .padding()
                }
            }
        }
    }


    
    private var saveButtonSection: some View {
        Button(action: viewModel.saveUserProfileCD) {
            Text("Guardar")
                .frame(width: 200, height: 50)
                .background(Color.orange)
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
