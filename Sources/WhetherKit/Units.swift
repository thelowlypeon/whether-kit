import Foundation

public enum WhetherUnit {
    case us // crazy
    case si // default
    case uk // same as si, except that nearestStormDistance and visibility are in miles, and windSpeed and windGust in miles per hour
    case ca // same as si, except that windSpeed and windGust are in kilometers per hour

    public struct WhetherMeasurement<WhetherMeasurementUnit: Unit> {
        public var value: Double { return measurement.value }
        public var unit: WhetherMeasurementUnit { return measurement.unit }
        private let measurement: Measurement<WhetherMeasurementUnit>

        public init(_ value: Double, unit: WhetherMeasurementUnit) {
            self.init(measurement: Measurement<WhetherMeasurementUnit>(value: value, unit: unit))
        }

        public init(measurement: Measurement<WhetherMeasurementUnit>) {
            self.measurement = measurement
        }
    }
}

extension WhetherUnit.WhetherMeasurement: CustomStringConvertible {
    public var description: String {
        return String(describing: measurement)
    }

    public func description(withPrecision precision: Int? = nil) -> String {
        guard let precision = precision else { return description }
        return String(format: "%.\(precision)f %@", value, unit.symbol)
    }
}

public protocol MeasurementWithDefaultUnit {
    associatedtype DefaultUnitType = Self
    static var defaultUnit: DefaultUnitType { get }
}

public protocol WhetherUnitConvertible {
    associatedtype UnitType = Self
    static func unit(for whetherUnit: WhetherUnit) -> UnitType
}

extension WhetherUnit.WhetherMeasurement: Decodable where WhetherMeasurementUnit: MeasurementWithDefaultUnit {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(
            try container.decode(Double.self),
            unit: WhetherMeasurementUnit.defaultUnit as! WhetherMeasurementUnit
        )
    }
}

extension WhetherUnit.WhetherMeasurement where WhetherMeasurementUnit: WhetherUnitConvertible, WhetherMeasurementUnit: Dimension {
    public func convert(to whetherUnit: WhetherUnit) -> WhetherUnit.WhetherMeasurement<WhetherMeasurementUnit> {
        return WhetherUnit.WhetherMeasurement<WhetherMeasurementUnit>(
            measurement: measurement.converted(
                to: WhetherMeasurementUnit.unit(for: whetherUnit) as! WhetherMeasurementUnit
            )
        )
    }
}

//extension WhetherUnit {
//    public var lengthUnit: UnitLength {
//        switch self {
//        case .us: return .inches
//        default: return .millimeters
//        }
//    }
//}
//extension UnitLength: MeasurementWithDefaultUnit {
//    public static var defaultUnit: UnitLength { return WhetherUnit.si.lengthUnit }
//}
