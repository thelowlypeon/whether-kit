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
            XCTAssertEqual(snapshot.snowAccumulation?.value, 1.4)
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

    func testDecodeDaily() {
        json = """
        {
            "latitude": 41,
            "longitude": -81,
            "timezone": "America/Chicago",
            "daily": {
                "summary": "Heavy rain throughout the week, with high temperatures rising to 29°C on Thursday.",
                "icon": "rain",
                "data": [
                    {
                        "time": 1568523600,
                        "summary": "Heavy rain in the morning.",
                        "icon": "rain",
                        "sunriseTime": 1568547127,
                        "sunsetTime": 1568592139,
                        "moonPhase": 0.56,
                        "precipIntensity": 0.8043,
                        "precipIntensityError": 0.2,
                        "precipIntensityMax": 12.7852,
                        "precipIntensityMaxTime": 1568545200,
                        "precipProbability": 1,
                        "precipType": "rain",
                        "temperatureHigh": 26.34,
                        "temperatureHighTime": 1568588400,
                        "temperatureLow": 21.21,
                        "temperatureLowTime": 1568635200,
                        "apparentTemperatureHigh": 27.65,
                        "apparentTemperatureHighTime": 1568588400,
                        "apparentTemperatureLow": 21.59,
                        "apparentTemperatureLowTime": 1568635200,
                        "dewPoint": 16.78,
                        "humidity": 0.74,
                        "pressure": 1017.22,
                        "windSpeed": 3.16,
                        "windGust": 6.84,
                        "windGustTime": 1568541600,
                        "windBearing": 202,
                        "cloudCover": 0.67,
                        "uvIndex": 5,
                        "uvIndexTime": 1568574000,
                        "visibility": 15.63,
                        "ozone": 294,
                        "temperatureMin": 17.52,
                        "temperatureMinTime": 1568545200,
                        "temperatureMax": 26.34,
                        "temperatureMaxTime": 1568588400,
                        "apparentTemperatureMin": 17.66,
                        "apparentTemperatureMinTime": 1568545200,
                        "apparentTemperatureMax": 27.66,
                        "apparentTemperatureMaxTime": 1568588400
                    }
                ]
            }
        }
        """

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let report = try decoder.decode(WeatherReport.self, from: jsonData)
            XCTAssertNotNil(report.daily)
            XCTAssert((report.daily?.data.count ?? 0) > 0)
            guard let snapshot = report.daily?.data.first else { XCTFail("no daily"); return }
            XCTAssertEqual(snapshot.time, Date(timeIntervalSince1970: 1568523600))
            XCTAssertEqual(snapshot.dewPoint?.value, 16.78)
            XCTAssertEqual(snapshot.windSpeed?.value, 3.16)
            XCTAssertEqual(snapshot.windGust?.value, 6.84)
            XCTAssertEqual(snapshot.windBearing?.value, 202)
            XCTAssertEqual(snapshot.visibility.value, 15.63)
            XCTAssertEqual(snapshot.humidity?.value, 0.74)
            XCTAssertEqual(snapshot.precipProbability?.value, 1.0)
            XCTAssertEqual(snapshot.precipIntensity?.value, 0.8043)
            XCTAssertEqual(snapshot.precipIntensityError, 0.2)
            XCTAssertEqual(snapshot.snowAccumulation?.value, nil)
            XCTAssertEqual(snapshot.pressure?.value, 1017.22)
            XCTAssertEqual(snapshot.ozone?.value, 294)
            XCTAssertEqual(snapshot.uvIndex, 5)
            XCTAssertEqual(snapshot.cloudCover?.value, 0.67)
            XCTAssertEqual(snapshot.precipType, .rain)
            XCTAssertEqual(snapshot.apparentTemperatureHigh?.value, 27.65)
            XCTAssertEqual(snapshot.apparentTemperatureLow?.value, 21.59)
            XCTAssertEqual(snapshot.apparentTemperatureMin?.value, 17.66)
            XCTAssertEqual(snapshot.apparentTemperatureMax?.value, 27.66)
            XCTAssertEqual(snapshot.apparentTemperatureHighTime, Date(timeIntervalSince1970: 1568588400))
            XCTAssertEqual(snapshot.apparentTemperatureLowTime, Date(timeIntervalSince1970: 1568635200))
            XCTAssertEqual(snapshot.apparentTemperatureMinTime, Date(timeIntervalSince1970: 1568545200))
            XCTAssertEqual(snapshot.apparentTemperatureMaxTime, Date(timeIntervalSince1970: 1568588400))
            XCTAssertEqual(snapshot.moonPhase?.value, 0.56)
            XCTAssertEqual(snapshot.sunriseTime, Date(timeIntervalSince1970: 1568547127))
            XCTAssertEqual(snapshot.sunsetTime, Date(timeIntervalSince1970: 1568592139))
            XCTAssertEqual(snapshot.temperatureHigh?.value, 26.34)
            XCTAssertEqual(snapshot.temperatureLow?.value, 21.21)
            XCTAssertEqual(snapshot.precipIntensityMax?.value, 12.7852)
            XCTAssertEqual(snapshot.precipIntensityMaxTime, Date(timeIntervalSince1970: 1568545200))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testDecodeMinutely() {
        json = """
        {
            "latitude": 41,
            "longitude": -81,
            "timezone": "America/Chicago",
            "minutely": {
                "summary": "Mostly cloudy for the hour.",
                "icon": "partly-cloudy-day",
                "data": [
                    {
                        "time": 1568579760,
                        "precipIntensity": 0.8043,
                        "precipProbability": 1.0
                    }
                ]
            }
        }
        """

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let report = try decoder.decode(WeatherReport.self, from: jsonData)
            XCTAssertNotNil(report.minutely)
            XCTAssert((report.minutely?.data.count ?? 0) > 0)
            guard let snapshot = report.minutely?.data.first else { XCTFail("no minutely"); return }
            XCTAssertEqual(snapshot.time, Date(timeIntervalSince1970: 1568579760))
            XCTAssertEqual(snapshot.precipIntensity?.value, 0.8043)
            XCTAssertEqual(snapshot.precipProbability?.value, 1.0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
