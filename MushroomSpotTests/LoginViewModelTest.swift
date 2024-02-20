//
//  LoginViewModelTest.swift
//  MushroomSpotTests
//
//  Created by Tom.K on 20.02.2024..
//

import XCTest
@testable import MushroomSpot

final class LoginViewModelTest: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUpWithError() throws {
        viewModel = LoginViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    /** Check if e-mail address validation works properly. */
    func testEmailValidation() throws {
        [
            // Valid, dot in username.
            "john.doe@example.com" : true,
            // Valid, no dots for username.
            "johndoe@example.com" : true,
            // Valid, dash in username.
            "john-doe@example.com" : true,
            // Invalid, missing @ character.
            "john.doe.example.com" : false,
            // Invalid, missing domain.
            "john.doe@" : false,
            // Invalid, missing username.
            "@example.com" : false,
            // Invalid, blank.
            "" : false,
        ].forEach {
            assert(viewModel.validateEmail(value: $0.key) == $0.value)
        }
    }
    
    /** Check if password validation works properly. */
    func testPasswordValidation() throws {
        [
            // Valid, 8 characters, number, lowercase, uppercase, special character.
            "Test123!" : true,
            // Valid, 12 characters, same as above.
            "Test1234!?*&" : true,
            // Valid, 36 characters, same as above.
            "!?*&4321TseT!?*&4321TseT!?*&4321TseT" : true,
            // Invalid, missing number.
            "Test!?%&" : false,
            // Invalid, missing lowercase letter.
            "test123!" : false,
            // Invalid, missing uppercase letter.
            "TEST123!" : false,
            // Invalid, missing special character.
            "Test1234" : false,
            // Invalid, less than 8 characters.
            "Test12!" : false,
            // Invalid, blank.
            "" : false,
        ].forEach {
            assert(viewModel.validatePassword(value: $0.key) == $0.value)
        }
    }
    
}
