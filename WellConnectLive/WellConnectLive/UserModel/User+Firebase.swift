//
//  User+Firebase.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//
import Foundation
import FirebaseFirestore

// Extensión para AuthUser
extension AuthUser {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "email": email
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let email = documentData["email"] as? String else { return nil }
        
        self.id = id
        self.email = email
    }
}

// Extensión para UserProfile
extension UserProfile {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "apellidoPaterno": apellidoPaterno,
            "apellidoMaterno": apellidoMaterno ?? "",
            "genero": genero?.rawValue ?? "",
            "dni": dni,
            "direccion": direccion ?? "",
            "poblacion": poblacion ?? "",
            "pais": pais ?? "",
            "bloodType": bloodType?.rawValue ?? "",
            "edad": edad ?? 0,
            "fechaNacimiento": fechaNacimiento ?? Date(),
            "fechaInscripcion": fechaInscripcion ?? Date(),
            "phoneNumber": phoneNumber ?? "",
            "codigoPostal": codigoPostal ?? 0,
            "religion": religion?.rawValue ?? "",
            "photo": photo ?? "",
            "implants": implants?.map { $0.rawValue } ?? []
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let name = documentData["name"] as? String,
              let apellidoPaterno = documentData["apellidoPaterno"] as? String,
              let dni = documentData["dni"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.apellidoPaterno = apellidoPaterno
        self.dni = dni
        self.apellidoMaterno = documentData["apellidoMaterno"] as? String
        if let genderString = documentData["genero"] as? String {
            self.genero = Gender(rawValue: genderString)
        }
        self.direccion = documentData["direccion"] as? String
        self.poblacion = documentData["poblacion"] as? String
        self.pais = documentData["pais"] as? String
        if let bloodTypeString = documentData["bloodType"] as? String {
            self.bloodType = BloodType(rawValue: bloodTypeString)
        }
        self.edad = documentData["edad"] as? Int
        self.fechaNacimiento = documentData["fechaNacimiento"] as? Date
        self.fechaInscripcion = documentData["fechaInscripcion"] as? Date
        self.phoneNumber = documentData["phoneNumber"] as? String
        self.codigoPostal = documentData["codigoPostal"] as? Int
        if let religionString = documentData["religion"] as? String {
            self.religion = Religion(rawValue: religionString)
        }
        self.photo = documentData["photo"] as? String
        if let implantsArray = documentData["implants"] as? [String] {
            self.implants = implantsArray.compactMap { Implant(rawValue: $0) }
        }
    }
}

// Extensión para UserData
extension UserData {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "userType": userType?.rawValue ?? "",
            "note": note ?? "",
            "allowTracking": allowTracking ?? false,
            "contacts": contacts?.map { $0.toDocumentData() } ?? [],
            "diseases": diseases?.map { $0.toDocumentData() } ?? [],
            "allergies": allergies?.toDocumentData() ?? [:]
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String else { return nil }
        
        self.id = id
        if let userTypeString = documentData["userType"] as? String {
            self.userType = UserType(rawValue: userTypeString)
        }
        self.note = documentData["note"] as? String
        self.allowTracking = documentData["allowTracking"] as? Bool
        if let contactsData = documentData["contacts"] as? [[String: Any]] {
            self.contacts = contactsData.compactMap { Contact(from: $0) }
        }
        if let diseasesData = documentData["diseases"] as? [[String: Any]] {
            self.diseases = diseasesData.compactMap { Disease(from: $0) }
        }
        if let allergiesData = documentData["allergies"] as? [String: Any] {
            self.allergies = TypeAlergies(from: allergiesData)
        }
    }
}

// Extensión para Disease
extension Disease {
    func toDocumentData() -> [String: Any] {
        return [
            "type": type.rawValue,
            "name": name ?? "",
            "trackings": trackings?.map { $0.toDocumentData() } ?? []
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let typeString = documentData["type"] as? String,
              let type = DiseaseType(rawValue: typeString) else { return nil }

        self.type = type
        self.name = documentData["name"] as? String

        if let trackingData = documentData["trackings"] as? [[String: Any]] {
            self.trackings = trackingData.compactMap { DiseaseTracking(from: $0) }
        }
    }
}

// Extensión para DiseaseFile
extension DiseaseFile {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "fileType": fileType.rawValue,
            "url": url
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let fileTypeString = documentData["fileType"] as? String,
              let fileType = FileType(rawValue: fileTypeString),
              let url = documentData["url"] as? String else { return nil }

        self.id = id
        self.fileType = fileType
        self.url = url
    }
}

// Extensión para DiseaseTracking
extension DiseaseTracking {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "note": note ?? "",
            "date": date,
            "files": files?.map { $0.toDocumentData() } ?? []
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let date = documentData["date"] as? Date else { return nil }

        self.id = id
        self.date = date
        self.note = documentData["note"] as? String

        if let filesData = documentData["files"] as? [[String: Any]] {
            self.files = filesData.compactMap { DiseaseFile(from: $0) }
        }
    }
}

// Extensión para TypeAlergies
extension TypeAlergies {
    func toDocumentData() -> [String: Any] {
        return [
            "allergiesMedicamentos": allergiesMedicamentos?.map { $0.rawValue } ?? [],
            "allergiesAlimentacion": allergiesAlimentacion?.map { $0.rawValue } ?? [],
            "allergiesOtros": allergiesOtros?.map { $0.rawValue } ?? [],
            "allergyDescription" : allergyDescription ?? ""
        ]
    }


    init?(from documentData: [String: Any]) {
        if let medArray = documentData["allergiesMedicamentos"] as? [String] {
            self.allergiesMedicamentos = medArray.compactMap { AllergyMedicamentos(rawValue: $0) }
        }
        if let aliArray = documentData["allergiesAlimentacion"] as? [String] {
            self.allergiesAlimentacion = aliArray.compactMap { AllergyAlimentacion(rawValue: $0) }
        }
        if let otrosArray = documentData["allergiesOtros"] as? [String] {
            self.allergiesOtros = otrosArray.compactMap { AllergyOtros(rawValue: $0) }
        }
        self.allergyDescription = documentData["allergyDescription"] as? String
    }

}

// Extensión para Contact
extension Contact {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "parentesco": parentesco?.rawValue ?? "",
            "email": email ?? "",
            "phoneNumber": phoneNumber ?? "",
            "direccion": direccion ?? "",
            "compartirUbicacion": compartirUbicacion ?? false
        ]
    }

    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let name = documentData["name"] as? String else { return nil }

        self.id = id
        self.name = name

        if let parentString = documentData["parentesco"] as? String {
            self.parentesco = Parentesco(rawValue: parentString)
        }
        self.email = documentData["email"] as? String
        self.phoneNumber = documentData["phoneNumber"] as? String
        self.direccion = documentData["direccion"] as? String
        self.compartirUbicacion = documentData["compartirUbicacion"] as? Bool
    }
}

extension Parentesco {
    func toDocumentData() -> String {
        return self.rawValue
    }
    
    init?(from documentData: String) {
        self.init(rawValue: documentData)
    }
}


/*
extension AuthUser {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "email": email
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let email = documentData["email"] as? String else { return nil }
        
        self.id = id
        self.email = email
    }
}

extension UserRegister {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "apellidoPaterno": apellidoPaterno,
            "apellidoMaterno": apellidoMaterno,
            "fechaInscripcion": Timestamp(date: fechaInscripcion),
            "dni": dni
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let name = documentData["name"] as? String,
              let apellidoPaterno = documentData["apellidoPaterno"] as? String,
              let apellidoMaterno = documentData["apellidoMaterno"] as? String,
              let fechaInscripcion = (documentData["fechaInscripcion"] as? Timestamp)?.dateValue(),
              let dni = documentData["dni"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.fechaInscripcion = fechaInscripcion
        self.dni = dni
    }
}

extension UserData {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "genero": genero.rawValue,
            "fechaNacimiento": Timestamp(date: fechaNacimiento),
            "pais": pais,
            "calle": calle,
            "colonia": colonia as Any,
            "localidad": localidad,
            "cp": cp,
            "bloodType": bloodType.rawValue,
            "religion": religion.rawValue,
            "userType": userType.rawValue,
            "nota": nota,
            "allowTracking": allowTracking,
            "contacts": contacts.map { $0.toDocumentData() },
            "diseases": diseases.map { $0.toDocumentData() }
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let generoRaw = documentData["genero"] as? String,
              let genero = Gender(rawValue: generoRaw),
              let fechaNacimiento = (documentData["fechaNacimiento"] as? Timestamp)?.dateValue(),
              let pais = documentData["pais"] as? String,
              let calle = documentData["calle"] as? String,
              let localidad = documentData["localidad"] as? String,
              let cp = documentData["cp"] as? Int,
              let bloodTypeRaw = documentData["bloodType"] as? String,
              let bloodType = BloodType(rawValue: bloodTypeRaw),
              let religionRaw = documentData["religion"] as? String,
              let religion = Religion(rawValue: religionRaw),
              let userTypeRaw = documentData["userType"] as? String,
              let userType = UserType(rawValue: userTypeRaw),
              let nota = documentData["nota"] as? String,
              let allowTracking = documentData["allowTracking"] as? Bool,
              let contactsData = documentData["contacts"] as? [[String: Any]],
              let diseasesData = documentData["diseases"] as? [[String: Any]]
        else { return nil }
        
        let contacts = contactsData.compactMap { Contact(from: $0) }
        let diseases = diseasesData.compactMap { Disease(from: $0) }
        
        self.init(id: id, genero: genero, fechaNacimiento: fechaNacimiento, pais: pais, calle: calle, colonia: documentData["colonia"] as? String, localidad: localidad, cp: cp, bloodType: bloodType, religion: religion, userType: userType, nota: nota, allowTracking: allowTracking, contacts: contacts, diseases: diseases)
    }
}

extension Contact {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "phoneNumber": phoneNumber
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let name = documentData["name"] as? String,
              let phoneNumber = documentData["phoneNumber"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
}

extension Disease {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "tracking": tracking.map { $0.toDocumentData() }
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let name = documentData["name"] as? String,
              let trackingData = documentData["tracking"] as? [[String: Any]] else { return nil }
        
        let tracking = trackingData.compactMap { Tracking(from: $0) }
        
        self.init(id: id, name: name, tracking: tracking)
    }
}

extension Tracking {
    func toDocumentData() -> [String: Any] {
        return [
            "notes": notes
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let notes = documentData["notes"] as? String else { return nil }
        
        self.init(notes: notes)
    }
}

*/
