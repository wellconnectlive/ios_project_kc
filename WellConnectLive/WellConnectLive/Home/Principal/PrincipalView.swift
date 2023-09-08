//
//  PrincipalView.swift
//  WellConnectLive
//
//  Created by Alex Riquelme on 31-08-23.
//

import SwiftUI

struct PrincipalView: View {
    
    @State private var location = false
    @State private var data:String = "dOH2oSX3PleU6bg33A6nriePhIi1"  //TODO: Inyectar el id del usuario desde firebase
    
    
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                    //Botón de ajustes a la derecha
                    Button {
                        //TODO: Abrir el menú lateral "Ajustes"
                        print("soy el botón de AJUSTES")
                    } label: {
                        Image(systemName: "text.justify")
                            .foregroundColor(Color("ColorTextButton"))
                    }
                    Spacer()
                    
                    //Texto central "WellConnect"
                    Text("WellConnect")
                        .bold()
                        .offset(x:10)
                        .font(.system(size: 18))   //Tamaño de letra
                    
                    Spacer()
                    
                    //Imagen de perfil
                    Button {
                        //TODO: Preguntar que hace al presionar la imagen de perfil
                        print("soy el botón IMAGEN DE PERFIL")
                    } label: {
                        Image(systemName: "person")  //TODO: Inyectar la imagen desde firebase
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)  //padding horizontal para el hstack
                
                
                HStack{   //Reemplazar por un scrollView
                    Button {
                        //TODO: Acción de botón "Mi Ubicación"
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                    }
                    
                    Button {
                        //TODO: Acción del botón "Emergencia"
                    } label: {
                        
                    }
                    
                    Button {
                        //TODO: Acción del botón Avisar a mi gente
                    } label: {
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .cornerRadius(10)
                .background(Color.gray)
                .opacity(0.2)

                
                
                HStack{
                    Toggle("Seguimiento en vivo", isOn: $location)
                        .foregroundColor(Color("ColorButton"))
                        .bold()
                        .padding(16)
                        .onChange(of: location) { newValue in  //Se puede realizar la acción deseada
                            if newValue{
                                print("Toggle Presionado a \(newValue)")
                            }else{
                                print("Toggle Presionado a \(newValue)")
                            }
                        }
                }
                
                .background(Rectangle())
                .frame(width: 293, height: 45)
                .foregroundColor(Color("ColorFont1"))
                .cornerRadius(15)
                .padding(.horizontal,30)
                
                
                
                //Para el qr y la foto de perfil
                HStack{
                    //Vista del qr
                    QRCodeView(url: "http://wellnesconnect.xystems.com.mx/user?data=\(data)")
                    //QRCodeView(url: "www.instagram.com")
                    Image(systemName: "person")  //TODO: Inyectar la imagen desde firebase
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .padding(.leading, 60)
                }
                .frame(width: 360,height: 174,  alignment: .center)
                .background(Color("ColorButton2"))
                .cornerRadius(10)
                .padding(.bottom,10)
                
                HStack(){
                    Text("Mis seguimientos")
                        .font(.system(size: 14))
                        .bold()
                        .offset(x:20)
                    Spacer()
                    
                }
                
                //Tarjeta de "Mis Seguimientos"
                HStack{
                    Image("persona1")
                        .resizable()
                        .frame(width: 82, height: 82)
                        .clipShape(Circle())
                        .foregroundColor(.black)
                        .padding(.leading, 21)
                        .padding([.top, .bottom], 14)
                    
                    VStack{
                        Text("relación")
                            .font(.system(size: 10))
                        Text("Mamá")
                            .font(.system(size: 15))
                            .bold()
                        Text("Alzehimer")
                            .font(.system(size: 10))
                            .bold()
                    }
                    .foregroundColor(Color("ColorTextButton"))
                    .padding(.leading,16)
                    Spacer()
                    
                    Button {
                        //TODO: Abrir el mapa
                       
                    } label: {
                        VStack{
                            Image("Seguimiento")
                                .resizable()
                                .frame(width: 29, height: 29)
                                .foregroundColor(Color.red)
                            
                            Text("Seguimiento en \ntiempo real")
                                .font(.system(size: 12))
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 125, height: 84)
                        .background(Rectangle())
                        .foregroundColor(Color("ColorTextButton"))
                        .cornerRadius(15)
                        .padding(.trailing, 29)
                    }
                    
                }
               .background(Rectangle())
               .frame(width: 362,height: 108)
               .foregroundColor(Color("ColorFont1"))
               .cornerRadius(15)
               //.shadow(radius: 5)
               .padding([.leading, .trailing])
    
                
                //Tarjeta Hazte Premium
                HStack{
                    VStack{
                        Text("Hazte premium")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .bold()
                            .padding(.top,-20)
                        Text("Personalizado")
                            .font(.system(size: 12))
                            .foregroundColor(Color("ColorTitle1"))
                    }
                    .padding(.leading, 18)
                    Spacer()
                    Image("Mon1")
                        .padding(.leading, -60)
                    Spacer()
                    
                }
                .background(Rectangle())
                .frame(width: 362, height: 100)
                .foregroundColor(Color("ColorFont1"))
                .cornerRadius(15)
                //.shadow(radius: 5)
                .padding([.leading, .trailing])
                .padding(.top, 46)
                
                Spacer()  
            }
            
            
            
            VStack {   //Para que el botón SOS no se mueva de su posición debe estar en el final de la jerarquia
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        //TODO: Acción del botón SOS
                        print("soy un botón de SOS")
                    } label: {
                        Text("SOS")
                            .font(.system(size: 18))
                            .frame(width: 70, height: 70)
                            .background(Color.red)
                            .clipShape(Circle())
                            .foregroundColor(Color.white)
                            .shadow(radius: 15)
                    }
                .padding()
                }
            }   //Aquí termina el botón SOS
        }
    }
}

struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
    }
}
