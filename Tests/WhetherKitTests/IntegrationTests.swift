//
//  IntegrationTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/7/19.
//

import XCTest
@testable import WhetherKit

class IntegrationTests: XCTestCase {
    let manager = Whether(baseURL: URL(string: "http://localhost:9292/api")!)

    func testFetchingWeather() {
        let expectation = self.expectation(description: "Received weather report")
        manager.weather(at: WhetherLocation(latitude: 81, longitude: 41)) {(result) in
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
}
