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
    var id: String
    var userType: UserType?
    var note: String?
    var allowTracking: Bool?
    var contacts: [Contact]?
    var diseases: [Disease]?
    var allergies: TypeAlergies?
    var qr : String?
}

struct Disease: Codable {
    enum DiseaseType: String, Codable, CaseIterable {
        case discapacidadIntelectual
        case diabetes
        case hipertension
        case alzheimer
        case autismo
        case enfermedadVonWillebrand
        case hemofilia
        case demenciaSenil
        case sordera
        case other // Para enfermedades escritas a mano por el usuario
    }
    
    let type: DiseaseType
    var name: String? // Esto sería para cuando la enfermedad es 'other' y el usuario la escribe manualmente
    var trackings: [DiseaseTracking]?
}

struct DiseaseFile: Codable {
    enum FileType: String, Codable {
        case pdf
        case jpg
        case png
    }
    
    let id: String
    let fileType: FileType
    let url: String
}

struct DiseaseTracking: Codable {
    let id: String
    let note: String?
    let date: Date
    var files: [DiseaseFile]?
}

struct TypeAlergies: Codable {
    var allergiesMedicamentos: [AllergyMedicamentos]?
    var allergiesAlimentacion: [AllergyAlimentacion]?
    var allergiesOtros: [AllergyOtros]?
    var allergyDescription: String?
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
    case no = "N/C"

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
    var id: String { self.rawValue }
    case no = "N/C"
    case hija = "Hija"
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




