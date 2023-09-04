//
//  WellConnectLiveTests.swift
//  WellConnectLiveTests
//
//  Created by Markel Juaristi on 26/7/23.
//

import XCTest
@testable import WellConnectLive

final class WellConnectLiveTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
///MODEL
class ModelsTests: XCTestCase {

    func testUserProfileInitialization() {
        // Creando datos ficticios
        let date = Date()
        let implants: [Implant] = [.marcapasos]
        
        let profile = UserProfile(id: "1234",
                                  name: "Juan",
                                  apellidoPaterno: "Perez",
                                  apellidoMaterno: "Lopez",
                                  genero: .male,
                                  dni: "98765432",
                                  direccion: "Avenida Siempre Viva",
                                  poblacion: "Springfield",
                                  pais: "EE.UU",
                                  bloodType: .Aplus,
                                  edad: 25,
                                  fechaNacimiento: date,
                                  fechaInscripcion: date,
                                  phoneNumber: "987654321",
                                  codigoPostal: 12345,
                                  religion: .cristianoApostolicoRomano,
                                  photo: "https://example.com/photo.jpg",
                                  implants: implants)

        // Validar datos
        XCTAssertEqual(profile.id, "1234")
        XCTAssertEqual(profile.name, "Juan")
        XCTAssertEqual(profile.apellidoPaterno, "Perez")
        XCTAssertEqual(profile.apellidoMaterno, "Lopez")
        XCTAssertEqual(profile.genero, .male)
        XCTAssertEqual(profile.dni, "98765432")
        XCTAssertEqual(profile.direccion, "Avenida Siempre Viva")
        XCTAssertEqual(profile.poblacion, "Springfield")
        XCTAssertEqual(profile.pais, "EE.UU")
        XCTAssertEqual(profile.bloodType, .Aplus)
        XCTAssertEqual(profile.edad, 25)
        XCTAssertEqual(profile.fechaNacimiento, date)
        XCTAssertEqual(profile.fechaInscripcion, date)
        XCTAssertEqual(profile.phoneNumber, "987654321")
        XCTAssertEqual(profile.codigoPostal, 12345)
        XCTAssertEqual(profile.religion, .cristianoApostolicoRomano)
        XCTAssertEqual(profile.photo, "https://example.com/photo.jpg")
        XCTAssertEqual(profile.implants?.first, .marcapasos)
    }

    
}



///TEST LOGIN
class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    func testIsValidEmail() {
        viewModel.username = "usuario@testeand.com"
        XCTAssertTrue(viewModel.isValidEmail(), "La función isValidEmail debería devolver true cuando el correo electrónico contiene @.")

        viewModel.username = "usuariotesteando.com"
        XCTAssertFalse(viewModel.isValidEmail(), "La función isValidEmail debería devolver false cuando el correo electrónico no contiene @.")
    }
}

///TESTS REGISTRARSE
class RegistrationViewModelTests: XCTestCase {
    var viewModel: RegistrationViewModel!
    var appState: AppState!

    override func setUp() {
        super.setUp()
        appState = AppState()
        viewModel = RegistrationViewModel(appState: appState)
    }
    
    func testIsValidEmail() {
        viewModel.email = "usuario@testeand.com"
        XCTAssertTrue(viewModel.isValidEmail())
        
        viewModel.email = "usuariotesteando.com"
        XCTAssertFalse(viewModel.isValidEmail())
    }
    
    func testAllFieldsRequired() {
        viewModel.email = ""
        viewModel.password = ""
        viewModel.repeatPassword = ""
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "Email y contraseñas son requeridos.")
    }
    
    func testPasswordsMatch() {
        viewModel.email = "usuario@testeand.com"
        viewModel.password = "password"
        viewModel.repeatPassword = "differentPassword"
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "Las contraseñas no coinciden.")
    }
    
    
}





///TEST LOGIN
class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    func testIsValidEmail() {
        viewModel.username = "usuario@testeand.com"
        XCTAssertTrue(viewModel.isValidEmail(), "La función isValidEmail debería devolver true cuando el correo electrónico contiene @.")

        viewModel.username = "usuariotesteando.com"
        XCTAssertFalse(viewModel.isValidEmail(), "La función isValidEmail debería devolver false cuando el correo electrónico no contiene @.")
    }
}

///TESTS REGISTRARSE
class RegistrationViewModelTests: XCTestCase {
    var viewModel: RegistrationViewModel!
    var appState: AppState!

    override func setUp() {
        super.setUp()
        appState = AppState()
        viewModel = RegistrationViewModel(appState: appState)
    }
    
    func testIsValidEmail() {
        viewModel.email = "usuario@testeand.com"
        XCTAssertTrue(viewModel.isValidEmail())
        
        viewModel.email = "usuariotesteando.com"
        XCTAssertFalse(viewModel.isValidEmail())
    }
    
    func testAllFieldsRequired() {
        viewModel.email = ""
        viewModel.password = ""
        viewModel.repeatPassword = ""
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "Email y contraseñas son requeridos.")
    }
    
    func testPasswordsMatch() {
        viewModel.email = "usuario@testeand.com"
        viewModel.password = "password"
        viewModel.repeatPassword = "differentPassword"
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "Las contraseñas no coinciden.")
    }
    
    
}


///TESTS PROFILE
class ProfileViewModelTests: XCTestCase {
    var viewModel: ProfileViewModel!
    var appState: AppState!

    override func setUp() {
        super.setUp()
        appState = AppState()
        viewModel = ProfileViewModel(appState: appState)
    }
    
    func testIsNameValid() {
        viewModel.name = "John"
        XCTAssertTrue(viewModel.isNameValid(name: viewModel.name))
        
        viewModel.name = "123"
        XCTAssertFalse(viewModel.isNameValid(name: viewModel.name))
        
        viewModel.name = ""
        XCTAssertFalse(viewModel.isNameValid(name: viewModel.name))
    }
    
    func testIsPhoneNumberValid() {
        viewModel.phoneNumber = "1234567890"
        XCTAssertTrue(viewModel.isPhoneNumberValid(phoneNumber: viewModel.phoneNumber))
        
        viewModel.phoneNumber = "123abc"
        XCTAssertFalse(viewModel.isPhoneNumberValid(phoneNumber: viewModel.phoneNumber))
        
        viewModel.phoneNumber = ""
        XCTAssertFalse(viewModel.isPhoneNumberValid(phoneNumber: viewModel.phoneNumber))
    }
    
    func testIsDniValid() {
        viewModel.dni = "12345678Z"
        XCTAssertTrue(viewModel.isDniValid(dni: viewModel.dni))
        
        viewModel.dni = "12345678"
        XCTAssertFalse(viewModel.isDniValid(dni: viewModel.dni))
        
        viewModel.dni = ""
        XCTAssertFalse(viewModel.isDniValid(dni: viewModel.dni))
    }
    
    func testIsNumberValid() {
        XCTAssertTrue(viewModel.isNumberValid(number: "1234567890"))
        
        XCTAssertFalse(viewModel.isNumberValid(number: "123abc"))
        
        XCTAssertFalse(viewModel.isNumberValid(number: ""))
    }
    
    func testAreAllFieldsValid() {
        viewModel.name = "John"
        viewModel.apellidoPaterno = "Doe"
        viewModel.apellidoMaterno = "Smith"
        viewModel.dni = "12345678Z"
        viewModel.phoneNumber = "1234567890"
        viewModel.codigoPostal = "12345"
        viewModel.edad = "30"
        XCTAssertTrue(viewModel.areAllFieldsValid())
        
        viewModel.name = "123"
        XCTAssertFalse(viewModel.areAllFieldsValid())
        
        viewModel.name = ""
        XCTAssertFalse(viewModel.areAllFieldsValid())
    }
}

///HEALTH INFO

class HealthInfoViewModelTests: XCTestCase {
    var viewModel: HealthInfoViewModel!
    var appState: AppState!

    override func setUp() {
        super.setUp()
        appState = AppState()
        viewModel = HealthInfoViewModel(appState: appState)
    }

    func testIsTrackingAllowed() {
        viewModel.allowTracking = true
        XCTAssertTrue(viewModel.isTrackingAllowed())
        
        viewModel.allowTracking = false
        XCTAssertFalse(viewModel.isTrackingAllowed())
    }

    func testAreAllRequiredDiseasesInformed() {
        viewModel.diseases = [Disease(type: .diabetes), Disease(type: .hipertension)]
        XCTAssertTrue(viewModel.areAllRequiredDiseasesInformed())

        viewModel.diseases = [Disease(type: .diabetes)]
        XCTAssertFalse(viewModel.areAllRequiredDiseasesInformed())
    }

    func testAreAllRequiredAllergiesInformed() {
        viewModel.allergiesMedicamentos = [.penicilina]
        XCTAssertTrue(viewModel.areAllRequiredAllergiesInformed())

        viewModel.allergiesMedicamentos = []
        XCTAssertFalse(viewModel.areAllRequiredAllergiesInformed())
    }

    func testAreAllValidationsTrue() {
        viewModel.allowTracking = true
        viewModel.diseases = [Disease(type: .diabetes), Disease(type: .hipertension)]
        viewModel.allergiesMedicamentos = [.penicilina]
        XCTAssertTrue(viewModel.areAllValidationsTrue())

        viewModel.allergiesMedicamentos = []
        XCTAssertFalse(viewModel.areAllValidationsTrue())
    }
}


///DISEASE

class OtherDiseasePopupViewModelTests: XCTestCase {
    var viewModel: OtherDiseasePopupViewModel!

    override func setUp() {
        super.setUp()
        viewModel = OtherDiseasePopupViewModel()
    }

    func testIsDiseaseEmpty() {
        XCTAssertNotNil(viewModel.isDiseaseEmpty(""))
        XCTAssertNil(viewModel.isDiseaseEmpty("Diabetes"))
    }

    func testIsDiseaseDuplicated() {
        viewModel.diseases.append("Diabetes")
        XCTAssertNotNil(viewModel.isDiseaseDuplicated("Diabetes"))
        XCTAssertNil(viewModel.isDiseaseDuplicated("Hipertensión"))
    }

    func testIsDiseaseValid() {
        viewModel.diseases.append("Diabetes")
        XCTAssertNil(viewModel.isDiseaseValid("Hipertensión"))
        XCTAssertNotNil(viewModel.isDiseaseValid(""))
        XCTAssertNotNil(viewModel.isDiseaseValid("Diabetes"))
    }
}

///CONTACT
class AddContactPopupViewModelTests: XCTestCase {
    var viewModel: AddContactPopupViewModel!

    override func setUp() {
        super.setUp()
        viewModel = AddContactPopupViewModel()
    }

    func testIsValidName() {
        XCTAssertTrue(viewModel.isValidName("John Doe"))
        XCTAssertFalse(viewModel.isValidName("John Doe123"))
        XCTAssertFalse(viewModel.isValidName("123456"))
        XCTAssertFalse(viewModel.isValidName(""))
    }

    func testIsValidEmail() {
        XCTAssertTrue(viewModel.isValidEmail("example@example.com"))
        XCTAssertFalse(viewModel.isValidEmail("example@example"))
        XCTAssertFalse(viewModel.isValidEmail("exampleexample.com"))
        XCTAssertFalse(viewModel.isValidEmail(""))
    }

    func testIsValidPhoneNumber() {
        XCTAssertTrue(viewModel.isValidPhoneNumber("123456789"))
        XCTAssertTrue(viewModel.isValidPhoneNumber("1234567890"))
        XCTAssertFalse(viewModel.isValidPhoneNumber("12345678"))
        XCTAssertFalse(viewModel.isValidPhoneNumber("12345678a"))
        XCTAssertFalse(viewModel.isValidPhoneNumber(""))
    }

    func testAreValidFields() {
        XCTAssertTrue(viewModel.areValidFields(name: "John Doe", email: "example@example.com", phoneNumber: "123456789"))
        XCTAssertFalse(viewModel.areValidFields(name: "John Doe123", email: "example@example.com", phoneNumber: "123456789"))
        XCTAssertFalse(viewModel.areValidFields(name: "John Doe", email: "exampleexample.com", phoneNumber: "123456789"))
        XCTAssertFalse(viewModel.areValidFields(name: "John Doe", email: "example@example.com", phoneNumber: "12345678"))
        XCTAssertFalse(viewModel.areValidFields(name: "", email: "example@example.com", phoneNumber: "123456789"))
        XCTAssertFalse(viewModel.areValidFields(name: "John Doe", email: "", phoneNumber: "123456789"))
        XCTAssertFalse(viewModel.areValidFields(name: "John Doe", email: "example@example.com", phoneNumber: ""))
    }
}

