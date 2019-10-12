//
//  PreferenceLoggingTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 10/12/19.
//

import XCTest
@testable import WhetherKit

@available(OSX 10.12, *)
class PreferenceLoggingTests: XCTestCase {
    var preferenceManager: PreferenceManager!
    var snapshot: WeatherReport.Currently.Snapshot!
    var preference: WhetherPreference!

    override func setUp() {
        preferenceManager = PreferenceManager(filePath: "preferences_test", restore: false)
        snapshot = WeatherReport.Currently.Snapshot(
            time: Date(),
            summary: "",
            icon: .cloudy,
            temperature: Measurement<UnitTemperature>(value: 10.0, unit: .fahrenheit),
            apparentTemperature: Measurement<UnitTemperature>(value: 10.0, unit: .celsius),
            dewPoint: Measurement<UnitTemperature>(value: 10.0, unit: .fahrenheit),
            windSpeed: Measurement<UnitSpeed>(value: 10.0, unit: .metersPerSecond),
            windGust: Measurement<UnitSpeed>(value: 10.0, unit: .metersPerSecond),
            windBearing: Measurement<UnitAngle>(value: 0.0, unit: .degrees),
            visibility: Measurement<UnitLength>(value: 10.0, unit: .miles),
            humidity: Measurement<UnitPercent>(value: 0.0, unit: .double),
            pressure: Measurement<UnitPressure>(value: 10.0, unit: .hectopascals),
            ozone: Measurement<UnitOzone>(value: 0.0, unit: .dobson),
            uvIndex: 0, cloudCover: Measurement<UnitPercent>(value: 90.0, unit: .percent),
            nearestStormDistance: Measurement<UnitLength>(value: 10.0, unit: .miles),
            nearestStormBearing: Measurement<UnitAngle>(value: 0.0, unit: .degrees),
            precipType: .rain,
            precipProbability: Measurement<UnitPercent>(value: 100.0, unit: .percent),
            precipIntensity: Measurement<UnitIntensity>(value: 1.0, unit: .mmPerHour),
            precipIntensityError: Measurement<UnitPercent>(value: 0.8, unit: .double),
            snowAccumulation: nil
        )
        preference = WhetherPreference(
            good: true,
            activityType: "running",
            snapshot: snapshot
        )
        super.setUp()
    }

    func testPersistingPreference() {
        do {
            try preferenceManager.log(preference)
        } catch {
            XCTFail(error.localizedDescription)
        }

        XCTAssertEqual(preferenceManager.preferences.count, 1)
    }

    func testRestoringPreferences() {
        do {
            try preferenceManager.log(preference)
            let archivedPreferences = try preferenceManager.loadPreferences()
            XCTAssertNotNil(archivedPreferences)
            XCTAssertEqual(archivedPreferences?.count, 1)
            let archivedPreference = archivedPreferences?.first
            XCTAssertEqual(archivedPreference?.good, preference.good)
            XCTAssertEqual(archivedPreference?.snapshot.time, preference.snapshot.time)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPersistingPreferenceUnits() {
        do {
            try preferenceManager.log(preference)
            let archivedPreferences = try preferenceManager.loadPreferences()
            XCTAssertEqual(archivedPreferences?.first?.snapshot.dewPoint?.unit, .celsius)
            XCTAssertEqual(archivedPreferences?.first?.snapshot.dewPoint, preference.snapshot.dewPoint)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
