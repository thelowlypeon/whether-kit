//
//  Hourly.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

extension WeatherReport {
    public class SnapshotHourly: SnapshotDetailed {}
    public struct Hourly {
        public let summary: String?
        public let icon: String?
        public let data: [WeatherReport.Snapshot<SnapshotHourly>]
    }
}

extension WeatherReport.Hourly: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Snapshot where T: WeatherReport.SnapshotHourly {
    public var temperature: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: temperatureCelsius, unit: .celsius)
    }

    public var apparentTemperature: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureCelsius, unit: .celsius)
    }

    public var snowAccumulation: Measurement<UnitLength>? {
        return Measurement<UnitLength>(value: precipAccumulationMillimeters, unit: .millimeters)
    }
}
