import Foundation

public struct WeatherSnapshot {
    public let time: Date

    public var temperature: WhetherUnit.Temperature
    public let apparentTemperature: WhetherUnit.Temperature?
    public let dewPoint: WhetherUnit.Temperature?

    public let humidity: WhetherUnit.Humidity? // between 0 and 1

    public let visibility: WhetherUnit.Distance?
    public let cloudCover: WhetherUnit.CloudCover?
    public let ozone: WhetherUnit.Ozone? // The columnar density of total atmospheric ozone at the given time in Dobson units, obviously
    public let uvIndex: Double?

    public let windSpeed: WhetherUnit.Speed? // m/s
    public let windGust: WhetherUnit.Speed? // m/s
    public let windBearing: WhetherUnit.CardinalDirection? // degrees, with 0º at true north

    public let precipIntensity: WhetherUnit.Intensity? // mm/hr
    public let precipProbability: WhetherUnit.Percent?
    public let precipIntensityError: WhetherUnit.Percent?

    public let pressure: WhetherUnit.Pressure? // Hectopascals

    public let summary: String?
    public let icon: String?
}

extension WeatherSnapshot: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperature = "temperature"
        case apparentTemperature = "apparentTemperature"
        case dewPoint = "dewPoint"
        case windSpeed = "windSpeed"
        case windGust = "windGust"
        case windBearing = "windBearing"
        case humidity = "humidity"
        case visibility = "visibility"
        case precipProbability = "precipProbability"
        case precipIntensity = "precipIntensity"
        case precipIntensityError = "precipIntensityError"
        case pressure = "pressure"
        case ozone = "ozone"
        case uvIndex = "uvIndex"
        case cloudCover = "cloudCover"
        case summary = "summary"
        case icon = "icon"
    }
}
