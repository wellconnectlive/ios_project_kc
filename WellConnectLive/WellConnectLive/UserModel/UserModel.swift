//
//  UserModel.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 26/7/23.
//


import Foundation

struct AuthUser: Codable {
    let id: String
    let email: String
}
struct UserRegister: Codable {
    let id: String
    var name: String
    var apellidoPaterno :String
    var apellidoMaterno : String
    let fechaInscripcion : Date
    let dni: String
}


struct UserData: Codable {
    let id: String
    var genero : Gender
    let fechaNacimiento: Date/* o String?*/
    var pais : String
    var calle: String
    var colonia : String?
    var localidad : String
    var cp : Int
    let bloodType: BloodType
    var religion : Religion
    var userType : UserType
    let nota : String
    var allowTracking : Bool
    var contacts: [Contact]
    var diseases: [Disease]
}
/*
struct UserType : Codable {
    let premium : Bool
    let freemium: Bool
}
*/

enum UserType: String, Codable {
    case premium
    case freemium
}
/*
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
 */
enum Religion: String, Codable {
    case cristianoApostolicoRomano
    case ortodoxo
    case judio
    case musulman
    case catolico
    case evangelista
    case testigoJehova
    case hinduismo
    case protestante
    case sunismo
    case chiismo
    case budismo
}
/*
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
*/
enum BloodType: String, Codable {
    case ABplus
    case ABminus
    case Aplus
    case Aminus
    case Bplus
    case Bminus
    case Oplus
    case Ominus
}
/*
struct Genero : Codable {
    let hombre : String
    let mujer : String
}
*/
enum Gender: String, Codable {
    case male
    case female
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
