//
//  WhetherPreferencesTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/21/19.
//

import XCTest
@testable import WhetherKit

@available(iOS 10, macOS 10.12, *)
class WhetherPreferencesTests: XCTestCase {
    var storage: WhetherCredentialStorage!
    var manager: Whether!

    override func setUp() {
        storage = WhetherCredentialStorageMemory()
        manager = Whether(
            manager: Whether.localNetworkingManager,
            credentialStorage: storage
        )
    }

    func testFetchingPreferences() {
        let expectation = self.expectation(description: "Received whether preferences")
        manager.preferences {(result) in
            switch result {
            case .success(let preferences):
                let preference = preferences.first
                XCTAssertNotNil(preference)
                XCTAssertNotNil(preference?.snapshot.apparentTemperature)
            case .failure(let error):
                XCTFail("Got an error \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
