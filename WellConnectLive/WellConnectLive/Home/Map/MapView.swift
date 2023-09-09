//
//  MapView.swift
//  WellConnectLive
//
//  Created by Alex Riquelme on 09-09-23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapAPI = MapAPI()
    @State private var text = ""
    
    var body: some View {
        VStack {
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
            
            
            //Mapa
            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) { location in
                MapMarker(coordinate: location.coordinate, tint: .blue)
                
            }
            //Campo de "Ingresa una dirección"
            TextField("Ingresa una dirección", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            //Botones de "buscar dirección" y "Ver donde estoy"
            HStack {
                Button {
                    mapAPI.getLocation(address: text, delta: 0.2)
                    print("Botón 'Buscar dirección' presionado")
                } label: {
                    Text("Buscar Dirección")
                        .font(.system(size: 12))
                        .frame(width: 164, height: 48)
                        .bold()
                        .foregroundColor(.white)
                        .background(Rectangle())
                        .foregroundColor(Color("ColorTextButton"))
                        .cornerRadius(12)
                        .padding(.bottom,10)
                }
                
                Button {
                    //TODO: Hacer métodos para mi ubicación
                } label: {
                    Text("Ver donde estoy")
                        .font(.system(size: 12))
                        .frame(width: 164, height: 48)
                        .bold()
                        .foregroundColor(.white)
                        .background(Rectangle())
                        .foregroundColor(Color("ColorTextButton"))
                        .cornerRadius(12)
                        .padding(.bottom,10)
                }
            }
            
            
            
            //Botones "Crear una ruta" y "Rutas favoritas"
            HStack{
                
                Button {
                    //TODO: Crear métodos para crear una nueva ruta
                } label: {
                    Text("Crear una ruta")
                        .font(.system(size: 12))
                        .frame(width: 164, height: 48)
                        .bold()
                        .foregroundColor(.white)
                        .background(Rectangle())
                        .foregroundColor(Color("ColorTextButton"))
                        .cornerRadius(12)
                        .padding(.bottom,40)
                }

                Button {
                    //TODO: Crear métodos para crear una nueva ruta
                } label: {
                    Text("Rutas favoritas")
                        .font(.system(size: 12))
                        .frame(width: 164, height: 48)
                        .bold()
                        .foregroundColor(.white)
                        .background(Rectangle())
                        .foregroundColor(Color("ColorTextButton"))
                        .cornerRadius(12)
                        .padding(.bottom,40)
                }
                
            }
            
            
            
            
            

        }
        //.ignoresSafeArea()
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
