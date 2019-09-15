//
//  WeatherSnapshotDecodingTests.swift
//  WhetherKitTests
//
//  Created by Peter Compernolle on 9/1/19.
//

import XCTest
@testable import WhetherKit

class WeatherSnapshotDecodingTests: XCTestCase {
    var json: String = "{}"
    var jsonData: Data { return json.data(using: .utf8)! }

    func testDecodeAlerts() {
        json = """
        {
            "latitude": 41,
            "longitude": -81,
            "timezone": "America/Chicago",
            "alerts": [
                {
                    "title": "Flood Watch for Mason, WA",
                    "time": 1509993277,
                    "expires": 1509993277,
                    "regions": ["cook county"],
                    "severity": "warning",
                    "description": "STUFF THAT'S USUALLY IN ALL CAPS",
                    "uri": "http://alerts.weather.gov/cap/wwacapget.php?x=WA1255E4DB8494.FloodWatch.1255E4DCE35CWA.SEWFFASEW.38e78ec64613478bb70fc6ed9c87f6e6"
                }
            ]
        }
        """

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let report = try decoder.decode(WeatherReport.self, from: jsonData)
            XCTAssertNotNil(report.alerts)
            guard let alert = report.alerts?.first else { XCTFail("no alerts"); return }
            XCTAssertEqual(alert.time, Date(timeIntervalSince1970: 1509993277))
            XCTAssertEqual(alert.title, "Flood Watch for Mason, WA")
            XCTAssertEqual(alert.regions, ["cook county"])
            XCTAssertEqual(alert.severity, .warning)
            XCTAssertEqual(alert.expires, Date(timeIntervalSince1970: 1509993277))
            XCTAssertEqual(alert.description, "STUFF THAT'S USUALLY IN ALL CAPS")
            XCTAssertEqual(alert.url?.absoluteString, "http://alerts.weather.gov/cap/wwacapget.php?x=WA1255E4DB8494.FloodWatch.1255E4DCE35CWA.SEWFFASEW.38e78ec64613478bb70fc6ed9c87f6e6")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testDecodeHourly() {
        json = """
        {
            "latitude": 41,
            "longitude": -81,
            "timezone": "America/Chicago",
            "hourly": {
                "summary": "the weather is good",
                "icon": "overcast",
                "data": [{
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
                    "precipAccumulation": 1.4,
                    "precipType": "rain",
                    "pressure": 100,
                    "ozone": 267,
                    "uvIndex": 2,
                    "cloudCover": 0.9
                }]
            }
        }
        """

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let report = try decoder.decode(WeatherReport.self, from: jsonData)
            XCTAssertNotNil(report.hourly)
            XCTAssert((report.hourly?.data.count ?? 0) > 0)
            guard let snapshot = report.hourly?.data.first else { XCTFail("no hourly"); return }
            XCTAssertEqual(snapshot.time, Date(timeIntervalSince1970: 1509993277))
            XCTAssertEqual(snapshot.temperature?.value, 21.0)
            XCTAssertEqual(snapshot.apparentTemperature?.value, 22.3)
            XCTAssertEqual(snapshot.dewPoint?.value, 19.1)
            XCTAssertEqual(snapshot.windSpeed?.value, 0.2)
            XCTAssertEqual(snapshot.windGust?.value, 0.5)
            XCTAssertEqual(snapshot.windBearing?.value, 270)
            XCTAssertEqual(snapshot.visibility.value, 5)
            XCTAssertEqual(snapshot.humidity?.value, 0.2)
            XCTAssertEqual(snapshot.precipProbability?.value, 0.1)
            XCTAssertEqual(snapshot.precipIntensity?.value, 1.5)
            XCTAssertEqual(snapshot.precipIntensityError, 0.2)
            XCTAssertEqual(snapshot.precipAccumulation?.value, 1.4)
            XCTAssertEqual(snapshot.pressure?.value, 100)
            XCTAssertEqual(snapshot.ozone?.value, 267)
            XCTAssertEqual(snapshot.uvIndex, 2)
            XCTAssertEqual(snapshot.cloudCover?.value, 0.9)
            XCTAssertEqual(snapshot.precipType, .rain)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testDecodeCurrently() {
        json = """
        {
            "latitude": 41,
            "longitude": -81,
            "timezone": "America/Chicago",
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
                "precipType": "rain",
                "pressure": 100,
                "ozone": 267,
                "uvIndex": 2,
                "cloudCover": 0.9,
                "nearestStormDistance": 1.5,
                "nearestStormBearing": 275.3
            }
        }
        """
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let report = try decoder.decode(WeatherReport.self, from: jsonData)
            XCTAssertNotNil(report.currently)
            let snapshot = report.currently!
            XCTAssertEqual(snapshot.time, Date(timeIntervalSince1970: 1509993277))
            XCTAssertEqual(snapshot.temperature?.value, 21.0)
            XCTAssertEqual(snapshot.apparentTemperature?.value, 22.3)
            XCTAssertEqual(snapshot.dewPoint?.value, 19.1)
            XCTAssertEqual(snapshot.windSpeed?.value, 0.2)
            XCTAssertEqual(snapshot.windGust?.value, 0.5)
            XCTAssertEqual(snapshot.windBearing?.value, 270)
            XCTAssertEqual(snapshot.visibility.value, 5)
            XCTAssertEqual(snapshot.humidity?.value, 0.2)
            XCTAssertEqual(snapshot.precipProbability?.value, 0.1)
            XCTAssertEqual(snapshot.precipIntensity?.value, 1.5)
            XCTAssertEqual(snapshot.precipIntensityError, 0.2)
            XCTAssertEqual(snapshot.pressure?.value, 100)
            XCTAssertEqual(snapshot.ozone?.value, 267)
            XCTAssertEqual(snapshot.uvIndex, 2)
            XCTAssertEqual(snapshot.cloudCover?.value, 0.9)
            XCTAssertEqual(snapshot.precipType, .rain)
            XCTAssertEqual(snapshot.nearestStormDistance?.value, 1.5)
            XCTAssertEqual(snapshot.nearestStormBearing?.value, 275.3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
