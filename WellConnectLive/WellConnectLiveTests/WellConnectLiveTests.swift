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

    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel()
    }
    
    func testAllFieldsRequired() {
        viewModel.firstName = ""
        viewModel.lastName1 = ""
        viewModel.lastName2 = ""
        viewModel.dni = ""
        viewModel.email = ""
        viewModel.password = ""
        viewModel.repeatPassword = ""
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "Todos los campos son requeridos.")
    }
    
    func testPasswordsMatch() {
        viewModel.firstName = "John"
        viewModel.lastName1 = "Doe"
        viewModel.lastName2 = "Smith"
        viewModel.dni = "12345678Z"
        viewModel.email = "usuario@testeand.com"
        viewModel.password = "password"
        viewModel.repeatPassword = "differentPassword"
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "Las contraseñas no coinciden.")
    }
    
    func testSuccessfulRegistration() {
        viewModel.firstName = "John"
        viewModel.lastName1 = "Doe"
        viewModel.lastName2 = "Smith"
        viewModel.dni = "12345678Z"
        viewModel.email = "usuario@testeand.com"
        viewModel.password = "password"
        viewModel.repeatPassword = "password"
        
        viewModel.registerUser()
        XCTAssertEqual(viewModel.errorMessage, "")
    }
}
