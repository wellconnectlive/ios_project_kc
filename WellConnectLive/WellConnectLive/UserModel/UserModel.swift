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

struct UserProfile: Codable {
    let id: String
    let name: String
    let apellidoPaterno: String
    var apellidoMaterno: String?
    var genero: Gender?
    let dni: String
    var direccion: String?
    var poblacion: String?
    var pais: String?
    var bloodType: BloodType?
    var edad: Int?
    var fechaNacimiento: Date?
    var fechaInscripcion: Date?
    var phoneNumber: String?
    var codigoPostal: Int?
    var religion: Religion?
    var photo: String?
    var implants: [Implant]?
}

struct UserData: Codable {
    let id: String
    var userType: UserType?
    var note: String?
    var allowTracking: Bool?
    var contacts: [Contact]?
    var discapacidadIntelectual: Bool?
    var diabetes: Bool?
    var hipertension: Bool?
    var alzheimer: Bool?
    var autismo: Bool?
    var enfermedadVonWillebrand: Bool?
    var hemofilia: Bool?
    var demenciaSenil: Bool?
    var sordera: Bool?
    var alergies: TypeAlergies?
    var otherDiseases : [String]? /* lo ponga para asegurar si añadimos de funcionalidad de escribir a mano enfermedad*/
    
}

struct TypeAlergies: Codable {
    var allergiesMedicamentos: AllergyMedicamentos?
    var allergiesAlimentacion: AllergyAlimentacion?
    var allergiesOtros: AllergyOtros?
}

enum UserType: String, Codable {
    case premium = "Premium"
    case freemium = "Freemium"
}

enum Religion: String, Codable, CaseIterable {
    case cristianoApostolicoRomano = "Cristiano Apostólico Romano"
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
    case No = "N/C"
}

enum BloodType: String, Codable, CaseIterable {
    case ABplus = "AB+"
    case ABminus = "AB-"
    case Aplus = "A+"
    case Aminus = "A-"
    case Bplus = "B+"
    case Bminus = "B-"
    case Oplus = "O+"
    case Ominus = "O-"
}

enum Gender: String, Codable, CaseIterable {
    case male = "Hombre"
    case female = "Mujer"
    case no = "N/C"
}

enum AllergyMedicamentos: String, Codable, CaseIterable {
    case antibioticos
    case antiinflamatorios
    case gluten
    case penicilina
    case aspirina
    case ibuprofeno
    case naproxenoSodico
    case sulfamidas
    case anticonvulsivos
    case no = "N/C"
}

enum AllergyAlimentacion: String, Codable, CaseIterable {
    case lecheDeVaca  = "Leche de vaca"
    case huevo
    case pescadosMariscos = "Pescados / Marisco"
    case frutosSecos = "Frutos secos"
    case trigo
    case melocoton
    case kiwi
    case platano
    case cacahuate
    case no = "N/C"
}

enum AllergyOtros: String, Codable, CaseIterable {
    case polen
    case acaros
    case moho
    case peloPielAnimales
    case piquetesAbeja
    case piquetesAvispa
    case hongos
    case no = "N/C"
}

enum Implant: String, Codable, CaseIterable {
    case marcapasos
    case desfibrilador
    case No = "N/C"
}

struct Contact: Codable, Identifiable {
    let id: String
    var name: String
    var parentesco: Parentesco?
    var email: String?
    var phoneNumber: String?
    var direccion: String?
    var compartirUbicacion: Bool?
}

enum Parentesco: String, Codable, Identifiable, CaseIterable {
    var id: String { self.rawValue } //no comprendo por que debo hacerlo me dice todo el rato que no es Identifiable, aun y con el protocolo
    
    case hija = "Higa"
    case hijo = "Hijo"
    case abuela = "Abuela"
    case abuelo = "Abuelo"
    case madre = "Madre"
    case padre = "Padre"
    case hermana = "Hermana"
    case hermano = "Hermano"
    case sobrino = "Sobrino"
    case amigo = "Amigo"
}





/*
import Foundation

struct AuthUser: Codable {
    let id: String
    let email: String
}

struct UserProfile: Codable {
    let id: String
    var name: String
    var apellidoPaterno: String
    var apellidoMaterno: String
    var genero: Gender
    let dni: String
    var direccion: String
    var poblacion: String
    var pais: String
    let bloodType: BloodType
    var edad: Int
    let fechaNacimiento: Date
    let fechaInscripcion: Date
    let phoneNumber: String
    var codigoPostal: Int
}

struct UserData: Codable {
    let id: String
    var religion: Religion
    var userType: UserType
    let nota: String
    var allowTracking: Bool
    var contacts: [Contact]
    var diseases: CommonDisease
    var allergiesMedicamentos: AllergyMedicamentos
    var allergiesAlimentacion: AllergyAlimentacion
    var allergiesOtros: AllergyOtros
    var implantes: Implant
}

enum UserType: String, Codable {
    case premium
    case freemium
}

enum Religion: String, Codable, CaseIterable {
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

enum BloodType: String, Codable , CaseIterable{
    case ABplus
    case ABminus
    case Aplus
    case Aminus
    case Bplus
    case Bminus
    case Oplus
    case Ominus
}

enum Gender: String, Codable , CaseIterable{
    case male
    case female
}

enum AllergyMedicamentos: String, Codable , CaseIterable{
    case antibioticos
    case antiinflamatorios
    case gluten
    case penicilina
    case aspirina
    case ibuprofeno
    case naproxenoSodico
    case sulfamidas
    case anticonvulsivos
}

enum AllergyAlimentacion: String, Codable, CaseIterable {
    case lecheDeVaca
    case huevo
    case pescadosMariscos
    case frutosSecos
    case trigo
    case melocoton
    case kiwi
    case platano
    case cacahuate
}

enum AllergyOtros: String, Codable, CaseIterable {
    case polen
    case acaros
    case moho
    case peloPielAnimales
    case piquetesAbeja
    case piquetesAvispa
    case hongos
}

enum CommonDisease: String, Codable , CaseIterable{
    case discapacidadIntelectual
    case diabetes
    case hipertension
    case alzheimer
    case autismo
    case enfermedadVonWillebrand
    case hemofilia
    case demenciaSenil
    case sordera
}

enum Implant: String, Codable, CaseIterable {
    case marcapasos
    case desfibrilador
}


struct Contact: Codable {
    let id: String
    let name: String
    let parentesco: Parentesco
    let email: String
    let phoneNumber: String
    let direccion: String
    let compartirUbicacion: Bool
}

enum Parentesco: String, Codable {
    case hija, hijo, abuela, abuelo, madre, padre, hermana, hermano, sobrino, amigo
}

struct Disease: Codable {
    let id: String
    let name: String
    var tracking: [Tracking]
}

struct Tracking: Codable {
    let notes: String
}

*/
