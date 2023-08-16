//
//  User+Firebase.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//
import FirebaseFirestore

extension AuthUser {
    var documentData: [String: Any] {
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

extension UserProfile {
    var documentData: [String: Any] {
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
        self.apellidoMaterno = documentData["apellidoMaterno"] as? String
        self.genero = Gender(rawValue: documentData["genero"] as? String ?? "")
        self.dni = dni
        self.direccion = documentData["direccion"] as? String
        self.poblacion = documentData["poblacion"] as? String
        self.pais = documentData["pais"] as? String
        self.bloodType = BloodType(rawValue: documentData["bloodType"] as? String ?? "")
        self.edad = documentData["edad"] as? Int
        self.fechaNacimiento = documentData["fechaNacimiento"] as? Date
        self.fechaInscripcion = documentData["fechaInscripcion"] as? Date
        self.phoneNumber = documentData["phoneNumber"] as? String
        self.codigoPostal = documentData["codigoPostal"] as? Int
        self.religion = Religion(rawValue: documentData["religion"] as? String ?? "")
        self.photo = documentData["photo"] as? String
        self.implants = (documentData["implants"] as? [String])?.compactMap(Implant.init)
    }
}

extension UserData {
    var documentData: [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "userType": userType?.rawValue ?? "",
            "note": note ?? "",
            "allowTracking": allowTracking ?? false,
            "contacts": contacts?.map { $0.documentData } ?? [],
            "discapacidadIntelectual": discapacidadIntelectual ?? false,
            "diabetes": diabetes ?? false,
            "hipertension": hipertension ?? false,
            "alzheimer": alzheimer ?? false,
            "autismo": autismo ?? false,
            "enfermedadVonWillebrand": enfermedadVonWillebrand ?? false,
            "hemofilia": hemofilia ?? false,
            "demenciaSenil": demenciaSenil ?? false,
            "sordera": sordera ?? false,
            "alergies": alergies?.documentData ?? [:],
            "otherDiseases": otherDiseases ?? []
        ]
        return data
    }
    
    init?(from documentData: [String: Any]) {
        guard let id = documentData["id"] as? String else { return nil }
        
        self.id = id
        self.userType = UserType(rawValue: documentData["userType"] as? String ?? "")
        self.note = documentData["note"] as? String
        self.allowTracking = documentData["allowTracking"] as? Bool
        if let contactsData = documentData["contacts"] as? [[String: Any]] {
            self.contacts = contactsData.compactMap(Contact.init)
        } else {
            self.contacts = nil
        }
        self.discapacidadIntelectual = documentData["discapacidadIntelectual"] as? Bool
        self.diabetes = documentData["diabetes"] as? Bool
        self.hipertension = documentData["hipertension"] as? Bool
        self.alzheimer = documentData["alzheimer"] as? Bool
        self.autismo = documentData["autismo"] as? Bool
        self.enfermedadVonWillebrand = documentData["enfermedadVonWillebrand"] as? Bool
        self.hemofilia = documentData["hemofilia"] as? Bool
        self.demenciaSenil = documentData["demenciaSenil"] as? Bool
        self.sordera = documentData["sordera"] as? Bool
        self.otherDiseases = documentData["otherDiseases"] as? [String]
        if let alergiesData = documentData["alergies"] as? [String: Any] {
            self.alergies = TypeAlergies(from: alergiesData)
        } else {
            self.alergies = nil
        }
    }
}

extension TypeAlergies {
    var documentData: [String: Any] {
        return [
            "allergiesMedicamentos": allergiesMedicamentos?.rawValue ?? "",
            "allergiesAlimentacion": allergiesAlimentacion?.rawValue ?? "",
            "allergiesOtros": allergiesOtros?.rawValue ?? ""
        ]
    }
    
    init?(from documentData: [String: Any]) {
        self.allergiesMedicamentos = AllergyMedicamentos(rawValue: documentData["allergiesMedicamentos"] as? String ?? "")
        self.allergiesAlimentacion = AllergyAlimentacion(rawValue: documentData["allergiesAlimentacion"] as? String ?? "")
        self.allergiesOtros = AllergyOtros(rawValue: documentData["allergiesOtros"] as? String ?? "")
    }
}

extension Contact {
    var documentData: [String: Any] {
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
        self.parentesco = Parentesco(rawValue: documentData["parentesco"] as? String ?? "")
        self.email = documentData["email"] as? String
        self.phoneNumber = documentData["phoneNumber"] as? String
        self.direccion = documentData["direccion"] as? String
        self.compartirUbicacion = documentData["compartirUbicacion"] as? Bool
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
