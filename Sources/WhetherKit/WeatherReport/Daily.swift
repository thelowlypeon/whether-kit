//
//  Daily.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

extension WeatherReport {
    public class SnapshotDaily: SnapshotDetailed {}
    public struct Daily {
        public let summary: String?
        public let icon: String?
        public let data: [WeatherReport.Snapshot<SnapshotDaily>]
    }
}

extension WeatherReport.Daily: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Snapshot where T: WeatherReport.SnapshotDaily {
    public var snowAccumulation: Measurement<UnitLength>? {
        return Measurement<UnitLength>(value: precipAccumulationMillimeters, unit: .millimeters)
    }

    public var apparentTemperatureHigh: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureHighCelsius, unit: .celsius)
    }

    public var apparentTemperatureLow: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureLowCelsius, unit: .celsius)
    }

    public var apparentTemperatureMax: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureMaxCelsius, unit: .celsius)
    }

    public var apparentTemperatureMin: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureMinCelsius, unit: .celsius)
    }

    public var apparentTemperatureHighTime: Date? { return apparentTemperatureHighTimeDate }

    public var apparentTemperatureLowTime: Date? { return apparentTemperatureLowTimeDate }

    public var apparentTemperatureMaxTime: Date? { return apparentTemperatureMaxTimeDate }

    public var apparentTemperatureMinTime: Date? { return apparentTemperatureMinTimeDate }

    public var moonPhase: Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(value: moonPhaseDouble, unit: .double)
    }

    public var precipIntensityMaxTime: Date? { return precipIntensityMaxTimeDate }

    public var precipIntensityMax: Measurement<UnitIntensity>? {
        return Measurement<UnitIntensity>(value: precipIntensityMaxMillimetersPerHour, unit: .mmPerHour)
    }

    public var sunriseTime: Date? { return sunriseTimeDate }

    public var sunsetTime: Date? { return sunsetTimeDate }

    public var temperatureHigh: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: temperatureHighCelsius, unit: .celsius)
    }

    public var temperatureLow: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: temperatureLowCelsius, unit: .celsius)
    }

    public var temperatureHighTime: Date? { return temperatureHighTimeDate }

    public var temperatureLowTime: Date? { return temperatureLowTimeDate }
}
