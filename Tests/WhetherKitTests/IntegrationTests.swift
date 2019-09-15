//
//  IntegrationTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/7/19.
//

import XCTest
@testable import WhetherKit
import SimpleNetworking

class WhetherCredentialStorageMemory: WhetherCredentialStorage {
    var credentials: Whether.Credentials?

    func restore() -> Whether.Credentials? {
        return credentials
    }

    func persist(credentials: Whether.Credentials?) {
        self.credentials = credentials
    }
}

class IntegrationTests: XCTestCase {
    var storage: WhetherCredentialStorage!
    var manager: Whether!

    override func setUp() {
        storage = WhetherCredentialStorageMemory()
        manager = Whether(
            manager: Whether.localNetworkingManager,
            credentialStorage: storage
        )
    }

    func testFetchingWeather() {
        let expectation = self.expectation(description: "Received weather report")
        manager.weather(at: Whether.Location(latitude: 81, longitude: 41)) {(result) in
            switch result {
            case .success(let report):
                let weatherReport = report
                XCTAssertNotNil(weatherReport)
                XCTAssertNotNil(weatherReport.currently?.apparentTemperature)
            case .failure(let error):
                XCTFail("Got an error \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testAuthenticationPersistence() {
        let expectation = self.expectation(description: "Received weather report")
        manager.weather(at: Whether.Location(latitude: 81, longitude: 41)) {(result) in
            switch result {
            case .success(_):
                XCTAssertNotNil(self.storage.restore())
                break
            case .failure(let error):
                XCTFail("Got an error \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
