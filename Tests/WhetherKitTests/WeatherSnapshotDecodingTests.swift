//
//  WeatherSnapshotDecodingTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/1/19.
//

import XCTest
@testable import WhetherKit

class WeatherSnapshotDecodingTests: XCTestCase {
    var json: String!
    var jsonData: Data { return json.data(using: .utf8)! }

    override func setUp() {
        json = """
        {
            "currently": {
                "time": 1509993277,
                "summary": "The weather is good",
                "icon": "overcast",
                "temperature": 21.0,
                "apparentTemperature": 22.3,
                "dewPoint": 19.1,
                "windSpeed": 0.2,
                "windGust": 0.5,
                "windBearing": 270,
                "visibility": 5,
                "humidity": 0.2,
                "precipProbability": 0.1,
                "precipIntensity": 1.5,
                "precipIntensityError": 0.2,
                "pressure": 100,
                "ozone": 267,
                "uvIndex": 2,
                "cloudCover": 0.9
            }
        }
        """
    }

    func testDecodingWhenAllFieldsArePresentAndValid() {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let report = try decoder.decode(WeatherReport.self, from: jsonData)
            XCTAssertNotNil(report.currently)
            let snapshot = report.currently!
            XCTAssertEqual(snapshot.time, Date(timeIntervalSince1970: 1509993277))
            XCTAssertEqual(snapshot.temperature.value, 21.0)
            XCTAssertEqual(snapshot.apparentTemperature?.value, 22.3)
            XCTAssertEqual(snapshot.dewPoint?.value, 19.1)
            XCTAssertEqual(snapshot.windSpeed?.value, 0.2)
            XCTAssertEqual(snapshot.windGust?.value, 0.5)
            XCTAssertEqual(snapshot.windBearing?.value, 270)
            XCTAssertEqual(snapshot.visibility?.value, 5)
            XCTAssertEqual(snapshot.humidity?.value, 0.2)
            XCTAssertEqual(snapshot.precipProbability?.value, 0.1)
            XCTAssertEqual(snapshot.precipIntensity?.value, 1.5)
            XCTAssertEqual(snapshot.precipIntensityError?.value, 0.2)
            XCTAssertEqual(snapshot.pressure?.value, 100)
            XCTAssertEqual(snapshot.ozone?.value, 267)
            XCTAssertEqual(snapshot.uvIndex, 2)
            XCTAssertEqual(snapshot.cloudCover?.value, 0.9)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
