//
//  User+Firebase.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 28/7/23.
//

import Foundation
import FirebaseFirestore

extension User {
    func toDocumentData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "apellidoPaterno": apellidoPaterno,
            "apellidoMaterno": apellidoMaterno,
            "genero": genero.rawValue,
            "fechaNacimiento": Timestamp(date: fechaNacimiento),
            "pais": pais,
            "calle": calle,
            "colonia": colonia ?? "",
            "localidad": localidad,
            "cp": cp,
            "fechaInscripcion": Timestamp(date: fechaInscripcion),
            "email": email,
            "dni": dni,
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
              let name = documentData["name"] as? String,
              let apellidoPaterno = documentData["apellidoPaterno"] as? String,
              let apellidoMaterno = documentData["apellidoMaterno"] as? String,
              let genero = Gender(rawValue: documentData["genero"] as? String ?? ""),
              let fechaNacimiento = (documentData["fechaNacimiento"] as? Timestamp)?.dateValue(),
              let pais = documentData["pais"] as? String,
              let calle = documentData["calle"] as? String,
              let localidad = documentData["localidad"] as? String,
              let cp = documentData["cp"] as? Int,
              let fechaInscripcion = (documentData["fechaInscripcion"] as? Timestamp)?.dateValue(),
              let email = documentData["email"] as? String,
              let dni = documentData["dni"] as? String,
              let bloodType = BloodType(rawValue: documentData["bloodType"] as? String ?? ""),
              let religion = Religion(rawValue: documentData["religion"] as? String ?? ""),
              let userType = UserType(rawValue: documentData["userType"] as? String ?? ""),
              let nota = documentData["nota"] as? String,
              let allowTracking = documentData["allowTracking"] as? Bool,
              let contactData = documentData["contacts"] as? [[String: Any]],
              let diseaseData = documentData["diseases"] as? [[String: Any]]
        else { return nil }
        
        self.id = id
        self.name = name
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.genero = genero
        self.fechaNacimiento = fechaNacimiento
        self.pais = pais
        self.calle = calle
        self.colonia = documentData["colonia"] as? String
        self.localidad = localidad
        self.cp = cp
        self.fechaInscripcion = fechaInscripcion
        self.email = email
        self.dni = dni
        self.bloodType = bloodType
        self.religion = religion
        self.userType = userType
        self.nota = nota
        self.allowTracking = allowTracking
        self.contacts = contactData.compactMap { Contact(from: $0) }
        self.diseases = diseaseData.compactMap { Disease(from: $0) }
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
              let phoneNumber = documentData["phoneNumber"] as? String
        else { return nil }
        
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
              let trackingData = documentData["tracking"] as? [[String: Any]]
        else { return nil }
        
        self.id = id
        self.name = name
        self.tracking = trackingData.compactMap { Tracking(from: $0) }
    }
}

extension Tracking {
    func toDocumentData() -> [String: Any] {
        return [
            "notes": notes
            // agregar otros campos si es necesario
        ]
    }
    
    init?(from documentData: [String: Any]) {
        guard let notes = documentData["notes"] as? String
        else { return nil }
        
        self.notes = notes
        // inicializar otros campos si es necesario
    }
}
