//
//  ContentView.swift
//  OnbordingWellConnect2
//
//  Created by Alex Riquelme on 16-08-23.
//

import SwiftUI

struct Onboarding: View {
    
    @EnvironmentObject var appState: AppState
    
//    @AppStorage ("pageIndex") private var pageIndex = 0
    @State private var pageIndex = 0
    
    private let pages: [Page] = Page.samplesPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack{
                    ZStack{
                        StandardView(page: page)
                        Image("LogoApp")
                        
                    }
                    //Configuramos lo que aparece en la última página
                    
                    if page == pages.last{
                        Button {
                            goToLogin()
                        } label: {
                            Text("Me apunto")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.vertical,20)  //Separación desde el texto hacia el borde inferior del botón
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("ColorTextButton"))
                                .background(Color("ColorButton"))
                                .cornerRadius(15)
                        }
                        .padding(.top,15)
                        .padding(.horizontal)
                        
                    } else {
                        Button {
                            incrementPage()
                        } label: {
                            Text("Me apunto")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.vertical,20)  //Separación desde el texto hacia el borde inferior del botón
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("ColorTextButton"))
                                .background(Color("ColorButton"))
                                .cornerRadius(15)
                        }
                        .padding(.top,15)
                        .padding(.horizontal)
                    }
                        
                    
                }.tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        
        .onAppear{
            dotAppearance.currentPageIndicatorTintColor = UIColor(named: "ColorButton")
            dotAppearance.pageIndicatorTintColor = .gray
        }
        .ignoresSafeArea()
    }
    
    
    func incrementPage(){
        pageIndex += 1
    }
    
    
    
    func goToLogin(){
        //Mover a la pantalla de login
        self.appState.navigationState = .login
    }
}




struct Page: Identifiable, Equatable {
    let id = UUID()
    let title: String       //titulo principal
    let subtitle: String    //titulo secundario
    let imageName:String    //nombre de imagen
    let tag:Int
    
    static var samplesPages: [Page] = [
        Page(title: "Bienvenidos a WellConnect", subtitle: "Mantén tu salud bajo control: Registra tu historial médico de forma organizada.", imageName: "Onboarding1", tag: 0),
        Page(title: "Siempre Conectado", subtitle: "Siempre conectado con tu salud: Comunícate directamente con los servicios médicos.", imageName: "Onboarding2", tag: 1),
        Page(title: "Todas tus citas a mano", subtitle: "Comparte confianza: Guarda los contactos que importan en casos urgentes.", imageName: "Onboarding3", tag: 2)
    ]
}



//Creo componente reutilizable para cada vista del onboarding
struct StandardView: View {
    
    var page: Page
    
    var body: some View{
        VStack{
            //Imagen
            Image(page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 400)
                .padding(.bottom, 30)
             
            //Titulo
            Text(page.title)
                .font(.system(size: 24))  //Tamaño de letra
                .foregroundColor(Color("ColorTitle"))
                .fontWeight(.heavy)    //Estilo letra negrita pesada
                .kerning(0.24)      //Espaciado entre letras
                .multilineTextAlignment(.center)   //Centrado
                .lineLimit(2)    //Máximo de lineas de texto
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 80)
           
            //Texto descriptivo
            Text(page.subtitle)
                .font(.system(size: 14))    //Tamaño de letra
                .multilineTextAlignment(.center)   //Centrado
                //.foregroundColor(Color(red: 113/255, green: 114/255, blue: 122/255))   //Color gris
                .padding(.top,10)
                .padding(.bottom, 22)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                
        
        }
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}


