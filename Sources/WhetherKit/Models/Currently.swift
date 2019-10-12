import Foundation

@available(iOS 10, macOS 10.12, *)
extension WeatherReport {
    public struct Currently {}
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Currently {
    public struct Snapshot {
        public let time: Date
        public let summary: String?
        public let icon: WeatherReport.Icon?
        public let temperature: Measurement<UnitTemperature>?
        public let apparentTemperature: Measurement<UnitTemperature>?
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
        public let nearestStormDistance: Measurement<UnitLength>?
        public let nearestStormBearing: Measurement<UnitAngle>?
        public let precipType: WeatherReport.PrecipitationType?
        public let precipProbability: Measurement<UnitPercent>?
        public let precipIntensity: Measurement<UnitIntensity>?
        public let precipIntensityError: Measurement<UnitPercent>?
        public let snowAccumulation: Measurement<UnitLength>?
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Currently.Snapshot: Codable {
    internal enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case temperature
        case apparentTemperature
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
        case nearestStormDistance
        case nearestStormBearing
        case precipType
        case precipProbability
        case precipIntensity
        case precipIntensityError
        case snowAccumulation = "precipAccumulation"
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
        self.temperature = try container.decodeTemperature(forKey: .temperature)
        self.apparentTemperature = try container.decodeTemperature(forKey: .apparentTemperature)
        self.nearestStormDistance = try container.decodeLength(forKey: .nearestStormDistance)
        self.nearestStormBearing = try container.decodeAngle(forKey: .nearestStormBearing)
        self.precipType = try container.decodePrecipitationType(forKey: .precipType)
        self.precipProbability = try container.decodePercent(forKey: .precipProbability)
        self.precipIntensity = try container.decodeIntensity(forKey: .precipIntensity)
        self.precipIntensityError = try container.decodePercent(forKey: .precipIntensityError)
        self.snowAccumulation = try container.decodeLength(forKey: .snowAccumulation, unit: .millimeters)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(time, forKey: .time)
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeSnapshotIcon(icon, forKey: .icon)
        try container.encodeTemperature(dewPoint, forKey: .dewPoint)
        try container.encodeSpeed(windSpeed, forKey: .windSpeed)
        try container.encodeSpeed(windGust, forKey: .windGust)
        try container.encodeAngle(windBearing, forKey: .windBearing)
        try container.encodeLength(visibility, forKey: .visibility)
        try container.encodePercent(humidity, forKey: .humidity)
        try container.encodePressure(pressure, forKey: .pressure)
        try container.encodeOzone(ozone, forKey: .ozone)
        try container.encodeIfPresent(uvIndex, forKey: .uvIndex)
        try container.encodePercent(cloudCover, forKey: .cloudCover)
        try container.encodeTemperature(temperature, forKey: .temperature)
        try container.encodeTemperature(apparentTemperature, forKey: .apparentTemperature)
        try container.encodeLength(nearestStormDistance, forKey: .nearestStormDistance)
        try container.encodeAngle(nearestStormBearing, forKey: .nearestStormBearing)
        try container.encodePrecipitationType(precipType, forKey: .precipType)
        try container.encodePercent(precipProbability, forKey: .precipProbability)
        try container.encodeIntensity(precipIntensity, forKey: .precipIntensity)
        try container.encodePercent(precipIntensityError, forKey: .precipIntensityError)
        try container.encodeLength(snowAccumulation, forKey: .snowAccumulation, unit: .millimeters)
    }
}
