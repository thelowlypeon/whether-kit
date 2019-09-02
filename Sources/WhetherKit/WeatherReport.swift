public struct WeatherReport {
    public let currently: WeatherSnapshot?
    public let hourly: [WeatherSnapshot]?
    public let daily: [WeatherSnapshot]?
    public let minutely: [WeatherSnapshot]?
}

extension WeatherReport: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case currently = "currently"
        case hourly = "hourly"
        case daily = "daily"
        case minutely = "minutely"
    }
}
