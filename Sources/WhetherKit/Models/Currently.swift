import Foundation

extension WeatherReport {
    public class SnapshotCurrently: SnapshotDetailed {}
    public typealias Currently = WeatherReport.Snapshot<SnapshotCurrently>
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Currently {
    public var nearestStormDistance: Measurement<UnitLength>? {
        return Measurement<UnitLength>(value: nearestStormDistanceKilometers, unit: .kilometers)
    }

    public var nearestStormBearing: Measurement<UnitAngle>? {
        return Measurement<UnitAngle>(value: nearestStormBearingDegrees, unit: .degrees)
    }

    public var temperature: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: temperatureCelsius, unit: .celsius)
    }

    public var apparentTemperature: Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(value: apparentTemperatureCelsius, unit: .celsius)
    }
}
