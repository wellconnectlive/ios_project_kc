//
//  User+Firebase.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//
import Foundation
import FirebaseFirestore

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
