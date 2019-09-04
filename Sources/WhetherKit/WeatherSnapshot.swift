import Foundation

public struct WeatherSnapshot {
    public let time: Date
    public let uvIndex: Double?
    public let summary: String?
    public let icon: String?

    private let temperatureCelsius: Double
    private let apparentTemperatureCelsius: Double?
    private let dewPointCelsius: Double?
    private let humidityDouble: Double?
    private let pressureHectopascals: Double?

    private let visibilityKilometers: Double?
    private let cloudCoverDouble: Double?
    private let ozoneDobsons: Double?

    private let windSpeedMetersPerSecond: Double?
    private let windGustMetersPerSecond: Double?
    private let windBearingDegrees: Double?

    private let precipIntensityMillimetersPerHour: Double?
    private let precipProbabilityDouble: Double?
    public let precipIntensityError: Double?
}

extension WeatherSnapshot {
    public var temperature: Measurement<UnitTemperature> {
        return Measurement<UnitTemperature>(value: temperatureCelsius, unit: .celsius)
    }

    public var apparentTemperature: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureCelsius, unit: .celsius)
    }

    public var dewPoint: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: dewPointCelsius, unit: .celsius)
    }

    public var humidity: Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(value: humidityDouble, unit: .double)
    }

    public var visibility: Measurement<UnitLength>? {
        return Measurement<UnitLength>(value: visibilityKilometers, unit: .kilometers)
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

    public var precipIntensity: Measurement<UnitIntensity>? {
        return Measurement<UnitIntensity>(value: precipIntensityMillimetersPerHour, unit: .mmPerHour)
    }

    public var precipProbability: Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(value: precipProbabilityDouble, unit: .double)
    }
}

extension WeatherSnapshot: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case time = "time"
        case summary = "summary"
        case icon = "icon"
        case temperatureCelsius = "temperature"
        case apparentTemperatureCelsius = "apparentTemperature"
        case dewPointCelsius = "dewPoint"
        case humidityDouble = "humidity"
        case visibilityKilometers = "visibility"
        case cloudCoverDouble = "cloudCover"
        case ozoneDobsons = "ozone"
        case uvIndex = "uvIndex"
        case windSpeedMetersPerSecond = "windSpeed"
        case windGustMetersPerSecond = "windGust"
        case windBearingDegrees = "windBearing"
        case pressureHectopascals = "pressure"
        case precipIntensityMillimetersPerHour = "precipIntensity"
        case precipProbabilityDouble = "precipProbability"
        case precipIntensityError = "precipIntensityError"
    }
}
