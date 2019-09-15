//
//  Snapshot.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

public protocol WhetherSnapshotType {}

extension WeatherReport {
    public class SnapshotDetailed: WhetherSnapshotType {} // everything but minutely

    public struct Snapshot<T: WhetherSnapshotType> {
        public let time: Date // all types

        internal let uvIndexDouble: Double? // not minutely
        internal let summaryString: String? // not minutely
        internal let iconString: String? // not minutely, TODO: make enum

        private let dewPointCelsius: Double? // detailed
        private let humidityDouble: Double? // detailed
        private let pressureHectopascals: Double? // detailed

        private let visibilityKilometers: Double? // detailed, max 10 miles
        private let cloudCoverDouble: Double?  // detailed
        private let ozoneDobsons: Double? // detailed

        private let windSpeedMetersPerSecond: Double? // detailed
        private let windGustMetersPerSecond: Double? // detailed
        private let windBearingDegrees: Double? // detailed, unless windSpeed is 0

        private let precipIntensityMillimetersPerHour: Double?
        private let precipProbabilityDouble: Double?
        public let precipIntensityError: Double?
        private let precipTypeString: String?

        internal let temperatureCelsius: Double? // only currently and hourly
        internal let apparentTemperatureCelsius: Double? // only currently and hourly
    
        internal let precipAccumulationMillimeters: Double? // only hourly and daily

        internal let nearestStormDistanceKilometers: Double? // only currently
        internal let nearestStormBearingDegrees: Double? // only currently
    }
}

extension WeatherReport.Snapshot: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case time = "time"
        case summaryString = "summary"
        case iconString = "icon"
        case uvIndexDouble = "uvIndex"
        case temperatureCelsius = "temperature"
        case apparentTemperatureCelsius = "apparentTemperature"
        case dewPointCelsius = "dewPoint"
        case humidityDouble = "humidity"
        case visibilityKilometers = "visibility"
        case cloudCoverDouble = "cloudCover"
        case ozoneDobsons = "ozone"
        case windSpeedMetersPerSecond = "windSpeed"
        case windGustMetersPerSecond = "windGust"
        case windBearingDegrees = "windBearing"
        case pressureHectopascals = "pressure"
        case precipIntensityMillimetersPerHour = "precipIntensity"
        case precipProbabilityDouble = "precipProbability"
        case precipIntensityError = "precipIntensityError"
        case precipTypeString = "precipType"
        case nearestStormDistanceKilometers = "nearestStormDistance"
        case nearestStormBearingDegrees = "nearestStormBearing"
        case precipAccumulationMillimeters = "precipAccumulation"
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Snapshot {
    public var precipIntensity: Measurement<UnitIntensity>? {
        return Measurement<UnitIntensity>(value: precipIntensityMillimetersPerHour, unit: .mmPerHour)
    }

    public var precipProbability: Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(value: precipProbabilityDouble, unit: .double)
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Snapshot where T: WeatherReport.SnapshotDetailed {
    public var uvIndex: Double? { return uvIndexDouble }
    public var summary: String? { return summaryString }
    public var icon: Icon? { return Icon(rawValue: iconString ?? "unknown") }

    public var dewPoint: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: dewPointCelsius, unit: .celsius)
    }

    public var humidity: Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(value: humidityDouble, unit: .double)
    }

    public var visibility: Measurement<UnitLength> {
        return Measurement<UnitLength>(value: visibilityKilometers ?? 16.09, unit: .kilometers)
    }

    public var cloudCover: Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(value: cloudCoverDouble, unit: .double)
    }

    public var ozone: Measurement<UnitOzone>? {
        return Measurement<UnitOzone>(value: ozoneDobsons, unit: .dobson)
    }

    public var windSpeed: Measurement<UnitSpeed>? {
        return Measurement<UnitSpeed>(value: windSpeedMetersPerSecond, unit: .metersPerSecond)
    }

    public var windGust: Measurement<UnitSpeed>? {
        return Measurement<UnitSpeed>(value: windGustMetersPerSecond, unit: .metersPerSecond)
    }

    public var windBearing: Measurement<UnitAngle>? { // degrees, with 0º at true north
        return Measurement<UnitAngle>(value: windBearingDegrees, unit: .degrees)
    }

    public var pressure: Measurement<UnitPressure>? {
        return Measurement<UnitPressure>(value: pressureHectopascals, unit: .hectopascals)
    }

    public var precipType: PrecipitationType? {
        return PrecipitationType(rawValue: precipTypeString ?? "unknown")
    }
}
