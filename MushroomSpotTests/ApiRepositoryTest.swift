//
//  ApiRepositoryTest.swift
//  MushroomSpotTests
//
//  Created by Tom.K on 19.02.2024..
//

import XCTest
@testable import MushroomSpot

final class ApiRepositoryTest: XCTestCase {
    
    // Note: This is not using a mock at this moment since it would require using an additional library.
    
    var apiRepository: ApiRepository! = nil
        
    override func setUpWithError() throws {
        apiRepository = ApiRepository(UIApplication.shared.delegate as! AppDelegate)
    }

    override func tearDownWithError() throws {
        apiRepository = nil
    }
    
    /** Check profile matches expected one.  */
    func testFetchProfile() throws {
        let expectation = expectation(description: "Fetch")
        
        let expectedProfileFetchItem = ProfileEntity(
            id: "1",
            username: "tester@example.com",
            firstName: "Test",
            lastName: "Tester"
        )
        
        apiRepository.fetchProfile { result in
            switch (result) {
            case .success(item: let item):
                assert(item.id == expectedProfileFetchItem.id)
                assert(item.username == expectedProfileFetchItem.username)
                assert(item.firstName == expectedProfileFetchItem.firstName)
                assert(item.lastName == expectedProfileFetchItem.lastName)
                expectation.fulfill()
            case .failure:
                assert(false)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    /** Check if there are exactly 11 mushrooms in list.  */
    func testFetchMushrooms() throws {
        let expectation = expectation(description: "Fetch")
        apiRepository.fetchMushrooms { result in
            switch (result) {
            case .success(items: let items):
                assert(items.count == 11)
                expectation.fulfill()
            case .failure:
                assert(false)
            }
        }
        waitForExpectations(timeout: 5)
    }

}
