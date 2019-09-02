//
//  UnitsTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/2/19.
//

import XCTest
@testable import WhetherKit

class UnitsTests: XCTestCase {
    let decoder = JSONDecoder()

    func testTemperature() {
        struct Dummy: Decodable {
            var temperature: WhetherUnit.Temperature
            enum CodingKeys: String, CodingKey {
                case temperature = "temperature"
            }
        }
        let jsonData = "{ \"temperature\": 23.8 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.temperature.value, 23.8)
            XCTAssertEqual(dummy.temperature.unit, UnitTemperature.celsius)
            let fahrenheit = dummy.temperature.convert(to: .us)
            XCTAssertEqual(fahrenheit.description(withPrecision: 1), "74.8 °F")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testDistance() {
        struct Dummy: Decodable {
            var distance: WhetherUnit.Distance
            enum CodingKeys: String, CodingKey {
                case distance = "distance"
            }
        }
        let jsonData = "{ \"distance\": 100 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.distance.value, 100)
            XCTAssertEqual(dummy.distance.unit, UnitDistance.kilometers)
            let miles = dummy.distance.convert(to: .us)
            XCTAssertEqual(miles.description(withPrecision: 1), "62.1 mi")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testHumidity() {
        struct Dummy: Decodable {
            var humidity: WhetherUnit.Humidity
            enum CodingKeys: String, CodingKey {
                case humidity = "humidity"
            }
        }
        let jsonData = "{ \"humidity\": 0.63 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.humidity.value, 0.63)
            let percent = dummy.humidity.convert(to: .us)
            XCTAssertEqual(percent.description(withPrecision: 0), "63 %")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
