//
//  UnitsTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/2/19.
//

import XCTest
@testable import WhetherKit

class UnitsTests: XCTestCase {
    func testPercent() {
        let double = Measurement<UnitPercent>(value: 0.5, unit: .double)
        XCTAssertEqual(double.value, 0.5)
        XCTAssertEqual(String(describing: double), "0.5 of 1")
        let percent = double.converted(to: .percent)
        XCTAssertEqual(percent.value, 50)
        XCTAssertEqual(String(describing: percent), "50.0 %")
    }

    func testOzone() {
        let ozone = Measurement<UnitOzone>(value: 267.0, unit: .dobson)
        XCTAssertEqual(ozone.value, 267)
        XCTAssertEqual(String(describing: ozone), "267.0 Dobsons")
    }

    func testIntensity() {
        let mmPerHour = Measurement<UnitIntensity>(value: 23.5, unit: .mmPerHour)
        XCTAssertEqual(mmPerHour.value, 23.5)
        XCTAssertEqual(String(describing: mmPerHour), "23.5 mm/hr")
        let inchesPerHour = mmPerHour.converted(to: .inchesPerHour)
        XCTAssertEqual(Int(inchesPerHour.value * 100), 92)
        XCTAssertEqual(inchesPerHour.description(withPrecision: 3), "0.925 in/hr")
    }
}
