public struct WeatherReport {
    public let latitude: Double
    public let longitude: Double
    public let timezone: String
    public let currently: WeatherReport.Snapshot<SnapshotCurrently>?
    public let hourly: WeatherReport.Hourly?
    public let alerts: [WeatherReport.Alert]?
}

extension WeatherReport: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case timezone = "timezone"
        case currently = "currently"
        case hourly = "hourly"
        case alerts = "alerts"
    }
}
