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
    var mockAuthService: MockAuthService!

    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
        viewModel = LoginViewModel(appState: AppState(), authService: mockAuthService) // Inyectamos el mock
    }

    func testIsValidEmail() {
        viewModel.username = "usuario@testeand.com"
        XCTAssertTrue(viewModel.isValidEmail(), "La función isValidEmail debería devolver true cuando el correo electrónico contiene @.")

        viewModel.username = "usuariotesteando.com"
        XCTAssertFalse(viewModel.isValidEmail(), "La función isValidEmail debería devolver false cuando el correo electrónico no contiene @.")
    }

    func testLoginSuccess() {
        mockAuthService.shouldReturnError = false // Aseguramos que no regrese error

        viewModel.username = "test@example.com"
        viewModel.password = "password123"
        viewModel.loginUser()

        XCTAssertTrue(viewModel.isLoggedIn)
        XCTAssertEqual(viewModel.errorMessage, "")
    }

    func testLoginFailure() {
        mockAuthService.shouldReturnError = true // Forzamos un error

        viewModel.username = "test@example.com"
        viewModel.password = "wrongpassword"
        viewModel.loginUser()

        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertNotEqual(viewModel.errorMessage, "")
    }
}


///TESTS REGISTRARSE
class RegistrationViewModelTests: XCTestCase {

    var sut: RegistrationViewModel!
    var mockAuthService: MockAuthService!
    var mockAppState: AppState!

    override func setUpWithError() throws {
        mockAuthService = MockAuthService()
        mockAppState = AppState()
        sut = RegistrationViewModel(appState: mockAppState, authService: mockAuthService)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockAuthService = nil
        mockAppState = nil
    }

    func testValidEmail() {
        sut.email = "test@example.com"
        XCTAssertTrue(sut.isValidEmail())
    }

    func testInvalidEmail() {
        sut.email = "testexample.com"
        XCTAssertFalse(sut.isValidEmail())
    }

    func testRegisterUserSuccess() {
        sut.email = "test@example.com"
        sut.password = "password123"
        sut.repeatPassword = "password123"

        let expectation = self.expectation(description: "Registration completed")

        mockAuthService.shouldReturnError = false

        sut.registerUser()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }

            XCTAssert(self.sut.errorMessage.isEmpty)
            XCTAssertEqual(self.mockAppState.navigationState, .verification)
        }
    }

    func testRegisterUserFailure() {
        sut.email = "test@example.com"
        sut.password = "password123"
        sut.repeatPassword = "password123"

        let expectation = self.expectation(description: "Registration failed")

        mockAuthService.shouldReturnError = true

        sut.registerUser()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }

            XCTAssertFalse(self.sut.errorMessage.isEmpty)
        }
    }
}









///TESTS PROFILE
class ProfileViewModelTests: XCTestCase {
    var viewModel: ProfileViewModel!
    var appState: AppState!
    var firestoreManagerMock: FirestoreManagerMock!

    override func setUp() {
        super.setUp()
        appState = AppState()
        viewModel = ProfileViewModel(appState: appState)
    }

    // Test para validar nombres
    func testIsNameValid() {
        XCTAssertTrue(viewModel.isNameValid(name: "Carlos"))
        XCTAssertFalse(viewModel.isNameValid(name: "12345"))
        XCTAssertFalse(viewModel.isNameValid(name: "Carlos123"))
        XCTAssertFalse(viewModel.isNameValid(name: ""))
    }

    // Test para validar números de teléfono
    func testIsPhoneNumberValid() {
        XCTAssertTrue(viewModel.isPhoneNumberValid(phoneNumber: "1234567890"))
        XCTAssertFalse(viewModel.isPhoneNumberValid(phoneNumber: "12345abcde"))
        XCTAssertFalse(viewModel.isPhoneNumberValid(phoneNumber: ""))
    }

    // Test para validar DNI
    func testIsDniValid() {
        XCTAssertTrue(viewModel.isDniValid(dni: "XYZ123456"))
        XCTAssertFalse(viewModel.isDniValid(dni: "!@#$%^&*()"))
        XCTAssertFalse(viewModel.isDniValid(dni: ""))
    }

    // Test para validar números
    func testIsNumberValid() {
        XCTAssertTrue(viewModel.isNumberValid(number: "123456"))
        XCTAssertFalse(viewModel.isNumberValid(number: "abcdef"))
        XCTAssertFalse(viewModel.isNumberValid(number: "123abc"))
        XCTAssertFalse(viewModel.isNumberValid(number: ""))
    }

    // Test para validar todos los campos
    func testAreAllFieldsValid() {
        viewModel.name = "Carlos"
        viewModel.apellidoPaterno = "Lopez"
        viewModel.apellidoMaterno = "Ramirez"
        viewModel.dni = "XYZ123456"
        viewModel.phoneNumber = "1234567890"
        viewModel.codigoPostal = "12345"
        viewModel.edad = "25"
        XCTAssertTrue(viewModel.areAllFieldsValid())
        
        viewModel.name = "12345"
        XCTAssertFalse(viewModel.areAllFieldsValid())
    }

    // Test para guardar el perfil del usuario
    func testSaveUserProfile() {
        // Configura los datos válidos
        viewModel.name = "Carlos"
        viewModel.apellidoPaterno = "Lopez"
        viewModel.apellidoMaterno = "Ramirez"
        viewModel.dni = "XYZ123456"
        viewModel.phoneNumber = "1234567890"
        viewModel.codigoPostal = "12345"
        viewModel.edad = "25"

        appState.userId = "testUserId"

        viewModel.saveUserProfile()

        
    }
}
///HEALTH INFO

class HealthInfoViewModelTests: XCTestCase {
    
    var sut: HealthInfoViewModel!
    var appStateMock: AppState!
    
    override func setUp() {
        super.setUp()
        appStateMock = AppState()
        sut = HealthInfoViewModel(appState: appStateMock)
    }
    
    override func tearDown() {
        sut = nil
        appStateMock = nil
        super.tearDown()
    }
    

    func testAreAllValidationsTrue_WithTrackingAllowed_ReturnsTrue() {
        sut.allowTracking = true
        
        XCTAssertTrue(sut.areAllValidationsTrue())
    }
    
    func testAreAllValidationsTrue_WithoutTrackingAllowed_ReturnsFalse() {
        sut.allowTracking = false
        
        XCTAssertFalse(sut.areAllValidationsTrue())
    }
    
}


///DISEASE

class OtherDiseasePopupViewModelTests: XCTestCase {
    
    var sut: OtherDiseasePopupViewModel!
    
    override func setUp() {
        super.setUp()
        sut = OtherDiseasePopupViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testIsDiseaseEmpty_WithEmptyDisease_ReturnsErrorMessage() {
        let result = sut.isDiseaseEmpty("")
        XCTAssertEqual(result, "El campo de enfermedad no puede estar vacío.")
    }
    
    func testIsDiseaseEmpty_WithNonEmptyDisease_ReturnsNil() {
        let result = sut.isDiseaseEmpty("Diabetes")
        XCTAssertNil(result)
    }
    
    func testIsDiseaseDuplicated_WithDuplicatedDisease_ReturnsErrorMessage() {
        sut.diseases = ["Diabetes"]
        
        let result = sut.isDiseaseDuplicated("Diabetes")
        XCTAssertEqual(result, "Esta enfermedad ya ha sido añadida.")
    }
    
    func testIsDiseaseDuplicated_WithNonDuplicatedDisease_ReturnsNil() {
        sut.diseases = ["Diabetes"]
        
        let result = sut.isDiseaseDuplicated("Cancer")
        XCTAssertNil(result)
    }
    
}

///CONTACT
class CircleOfTrustViewModelTests: XCTestCase {
    var viewModel: CircleOfTrustViewModel!
    var firestoreManagerMock: FirestoreManagerMock!
    var appStateMock: AppState!

    override func setUp() {
        super.setUp()
        firestoreManagerMock = FirestoreManagerMock()
        appStateMock = AppState()
        viewModel = CircleOfTrustViewModel(appState: appStateMock)
        viewModel.firestoreManager = firestoreManagerMock
    }

    func testAddOrUpdateContact_WithExistingContact_UpdatesContact() {
        let existingContact = Contact(id: "1", name: "John", email: "john@example.com", phoneNumber: "123456789")
        viewModel.contacts.append(existingContact)
        
        let updatedContact = Contact(id: "1", name: "John Updated", email: "johnupdated@example.com", phoneNumber: "987654321")
        viewModel.addOrUpdateContact(updatedContact)
        
        XCTAssertEqual(viewModel.contacts.first, updatedContact)
    }

    func testAddOrUpdateContact_WithNewContact_AddsContact() {
        let newContact = Contact(id: "2", name: "Jane", email: "jane@example.com", phoneNumber: "1234567890")
        viewModel.addOrUpdateContact(newContact)
        
        XCTAssertEqual(viewModel.contacts.first, newContact)
    }

    func testUpdateContactsAndSaveUserData_SavesUserData() {
        appStateMock.userId = "123"
        firestoreManagerMock.mockUserData = UserData(id: "123")
        
        viewModel.updateContactsAndSaveUserData()
        
        XCTAssertTrue(firestoreManagerMock.saveUserDataCalled)
    }

}


