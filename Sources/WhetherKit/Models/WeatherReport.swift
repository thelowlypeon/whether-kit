@available(iOS 10, macOS 10.12, *)
public struct WeatherReport {
    internal let latitude: Double
    internal let longitude: Double
    public var location: Whether.Location {
        return Whether.Location(latitude: latitude, longitude: longitude)
    }
    public let timezone: String

    public let currently: WeatherReport.Currently.Snapshot?
    public let minutely: WeatherReport.Minutely?
    public let hourly: WeatherReport.Hourly?
    public let daily: WeatherReport.Daily?
    public let alerts: [WeatherReport.Alert]?
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currently
        case minutely
        case hourly
        case daily
        case alerts
    }
}
