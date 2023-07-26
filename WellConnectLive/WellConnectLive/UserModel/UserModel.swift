//
//  UserModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//


import Foundation

struct User: Codable {
    let id: String
    var name: String
    var apellidoPaterno :String
    var apellidoMaterno : String
    var genero : Genero
    let fechaNacimiento: Date/* o String?*/
    var pais : String
    var calle: String
    var colonia : String?
    var localidad : String
    var cp : Int
    let fechaInscripcion : Date
    let email: String
    let dni: String
    let bloodType: BloodTypes
    var religion : Religion
    var userType : UserType
    let nota : String
    var allowTracking : Bool
    let password: String // Por seguridad, nunca debemos almacenar, lo pongo aqui, pero realmente no estoy seguro si debemos almacenarlo aqui(asi)
    var contacts: [Contact]
    var diseases: [Disease]
}

struct UserType : Codable {
    let premium : Bool
    let freemium: Bool
}

struct Religion :  Codable {
    let cristianoApostolicoRomano : Bool
    let ortodoxo : Bool
    let judio : Bool
    let musulman : Bool
    let catolico : Bool
    let evangelista : Bool
    let testigoJehova: Bool
    let hinduismo : Bool
    let protestante : Bool
    let sunismo : Bool
    let chiismo : Bool
    let budismo : Bool
}

struct BloodTypes : Codable {
    let ABplus : Bool
    let ABminus : Bool
    let Aplus : Bool
    let Aminus: Bool
    let Bplus : Bool
    let Bminus: Bool
    let Oplus : Bool
    let Ominus: Bool
}

struct Genero : Codable {
    let hombre : String
    let mujer : String
}

struct Contact: Codable {
    let id: String
    let name: String
    let phoneNumber: String
}

struct Disease: Codable {
    let id: String
    let name: String
    var tracking: [Tracking]
}

struct Tracking: Codable {
    /*let date: Timestamp*/ // El tipo Timestamp viene de Firebase
    let notes: String
}
