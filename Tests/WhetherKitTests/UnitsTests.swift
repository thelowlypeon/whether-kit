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

    func testSpeed() {
        struct Dummy: Decodable {
            var speed: WhetherUnit.Speed
            enum CodingKeys: String, CodingKey {
                case speed = "speed"
            }
        }
        let jsonData = "{ \"speed\": 12.3 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.speed.value, 12.3)
            let mph = dummy.speed.convert(to: .us)
            XCTAssertEqual(mph.description(withPrecision: 0), "28 mph")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testCardinalDirection() {
        struct Dummy: Decodable {
            var direction: WhetherUnit.CardinalDirection
            enum CodingKeys: String, CodingKey {
                case direction = "direction"
            }
        }
        let jsonData = "{ \"direction\": 90 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.direction.value, 90)
            let degrees = dummy.direction.convert(to: .us)
            XCTAssertEqual(degrees.description(withPrecision: 0), "90 °")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testIntensity() {
        struct Dummy: Decodable {
            var intensity: WhetherUnit.Intensity
            enum CodingKeys: String, CodingKey {
                case intensity = "intensity"
            }
        }
        let jsonData = "{ \"intensity\": 3.2 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.intensity.value, 3.2)
            XCTAssertEqual(dummy.intensity.description(withPrecision: 1), "3.2 mm/hr")
            let degrees = dummy.intensity.convert(to: .us)
            XCTAssertEqual(degrees.description(withPrecision: 2), "0.13 in/hr")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPressure() {
        struct Dummy: Decodable {
            var pressure: WhetherUnit.Pressure
            enum CodingKeys: String, CodingKey {
                case pressure = "pressure"
            }
        }
        let jsonData = "{ \"pressure\": 1010.34 }".data(using: .utf8)!
        do {
            let dummy = try decoder.decode(Dummy.self, from: jsonData)
            XCTAssertEqual(dummy.pressure.value, 1010.34)
            XCTAssertEqual(dummy.pressure.description(withPrecision: 1), "1010.3 hPa")
            let degrees = dummy.pressure.convert(to: .us)
            XCTAssertEqual(degrees.description(withPrecision: 2), "1010.34 mbar")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
