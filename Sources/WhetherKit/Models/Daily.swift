//
//  Daily.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

@available(iOS 10, macOS 10.12, *)
extension WeatherReport {
    public struct Daily {
        public let summary: String?
        public let icon: String?
        public let data: [WeatherReport.Daily.Snapshot]
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Daily: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Daily {
    public struct Snapshot {
        public let time: Date
        public let summary: String?
        public let icon: WeatherReport.Icon?
        public let dewPoint: Measurement<UnitTemperature>?
        public let windSpeed: Measurement<UnitSpeed>?
        public let windGust: Measurement<UnitSpeed>?
        public let windBearing: Measurement<UnitAngle>?
        public let visibility: Measurement<UnitLength>?
        public let humidity: Measurement<UnitPercent>?
        public let pressure: Measurement<UnitPressure>?
        public let ozone: Measurement<UnitOzone>?
        public let uvIndex: Double?
        public let cloudCover: Measurement<UnitPercent>?
        public let temperatureHigh: Measurement<UnitTemperature>?
        public let temperatureHighTime: Date?
        public let temperatureLow: Measurement<UnitTemperature>?
        public let temperatureLowTime: Date?
        public let apparentTemperatureHigh: Measurement<UnitTemperature>?
        public let apparentTemperatureHighTime: Date?
        public let apparentTemperatureLow: Measurement<UnitTemperature>?
        public let apparentTemperatureLowTime: Date?
        public let apparentTemperatureMax: Measurement<UnitTemperature>?
        public let apparentTemperatureMaxTime: Date?
        public let apparentTemperatureMin: Measurement<UnitTemperature>?
        public let apparentTemperatureMinTime: Date?
        public let moonPhase: Measurement<UnitPercent>? // percent with 0 new moon, 0.5 full moon, etc
        public let precipType: WeatherReport.PrecipitationType?
        public let precipProbability: Measurement<UnitPercent>?
        public let precipIntensity: Measurement<UnitIntensity>?
        public let precipIntensityError: Measurement<UnitPercent>?
        public let precipIntensityMax: Measurement<UnitIntensity>?
        public let precipIntensityMaxTime: Date?
        public let snowAccumulation: Measurement<UnitLength>?
        public let sunriseTime: Date?
        public let sunsetTime: Date?
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Daily.Snapshot: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case dewPoint
        case windSpeed
        case windGust
        case windBearing
        case visibility
        case humidity
        case pressure
        case ozone
        case uvIndex
        case cloudCover
        case temperatureHigh
        case temperatureHighTime
        case temperatureLow
        case temperatureLowTime
        case apparentTemperatureHigh
        case apparentTemperatureHighTime
        case apparentTemperatureLow
        case apparentTemperatureLowTime
        case apparentTemperatureMax
        case apparentTemperatureMaxTime
        case apparentTemperatureMin
        case apparentTemperatureMinTime
        case moonPhase
        case precipType
        case precipProbability
        case precipIntensity
        case precipIntensityError
        case precipIntensityMax
        case precipIntensityMaxTime
        case snowAccumulation = "precipAccumulation"
        case sunriseTime
        case sunsetTime
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.time = try container.decode(Date.self, forKey: .time)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.icon = try container.decodeSnapshotIcon(forKey: .icon)

        self.dewPoint = try container.decodeTemperature(forKey: .dewPoint)
        self.windSpeed = try container.decodeSpeed(forKey: .windSpeed)
        self.windGust = try container.decodeSpeed(forKey: .windGust)
        self.windBearing = try container.decodeAngle(forKey: .windBearing)

        self.visibility = try container.decodeLength(forKey: .visibility)
        self.humidity = try container.decodePercent(forKey: .humidity)
        self.pressure = try container.decodePressure(forKey: .pressure)
        self.ozone = try container.decodeOzone(forKey: .ozone)
        self.uvIndex = try container.decodeIfPresent(Double.self, forKey: .uvIndex)
        self.cloudCover = try container.decodePercent(forKey: .cloudCover)
        self.precipType = try container.decodePrecipitationType(forKey: .precipType)
        self.precipProbability = try container.decodePercent(forKey: .precipProbability)
        self.snowAccumulation = try container.decodeLength(forKey: .snowAccumulation, unit: .millimeters)

        self.temperatureHigh = try container.decodeTemperature(forKey: .temperatureHigh)
        self.temperatureHighTime = try container.decodeIfPresent(Date.self, forKey: .temperatureHighTime)

        self.temperatureLow = try container.decodeTemperature(forKey: .temperatureLow)
        self.temperatureLowTime = try container.decodeIfPresent(Date.self, forKey: .temperatureLowTime)

        self.apparentTemperatureHigh = try container.decodeTemperature(forKey: .apparentTemperatureHigh)
        self.apparentTemperatureHighTime = try container.decodeIfPresent(Date.self, forKey: .apparentTemperatureHighTime)

        self.apparentTemperatureLow = try container.decodeTemperature(forKey: .apparentTemperatureLow)
        self.apparentTemperatureLowTime = try container.decodeIfPresent(Date.self, forKey: .apparentTemperatureLowTime)

        self.apparentTemperatureMax = try container.decodeTemperature(forKey: .apparentTemperatureMax)
        self.apparentTemperatureMaxTime = try container.decodeIfPresent(Date.self, forKey: .apparentTemperatureMaxTime)

        self.apparentTemperatureMin = try container.decodeTemperature(forKey: .apparentTemperatureMin)
        self.apparentTemperatureMinTime = try container.decodeIfPresent(Date.self, forKey: .apparentTemperatureMinTime)

        self.moonPhase = try container.decodePercent(forKey: .moonPhase)

        self.precipIntensity = try container.decodeIntensity(forKey: .precipIntensity)
        self.precipIntensityError = try container.decodePercent(forKey: .precipIntensityError)
        self.precipIntensityMax = try container.decodeIntensity(forKey: .precipIntensityMax)
        self.precipIntensityMaxTime = try container.decodeIfPresent(Date.self, forKey: .precipIntensityMaxTime)

        self.sunriseTime = try container.decodeIfPresent(Date.self, forKey: .sunriseTime)
        self.sunsetTime = try container.decodeIfPresent(Date.self, forKey: .sunsetTime)
    }
}
