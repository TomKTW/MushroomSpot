//
//  SettingRepositoryTest.swift
//  MushroomSpotTests
//
//  Created by Tom.K on 19.02.2024..
//

import XCTest
@testable import MushroomSpot

final class SettingRepositoryTest: XCTestCase {
    
    var settingRepository: SettingRepository! = nil
    
    let authTokenTestValue = "Test123!"
    
    override func setUpWithError() throws {
        settingRepository = SettingRepository(UIApplication.shared.delegate as! AppDelegate)
    }

    override func tearDownWithError() throws {
        settingRepository = nil
    }

    /** Check if authorization token is properly stored. */
    func testSetAuthToken() throws {
        settingRepository.authToken = authTokenTestValue
        assert(settingRepository.authToken == authTokenTestValue)
        settingRepository.authToken = nil
        assert(settingRepository.authToken == nil)
    }

}
