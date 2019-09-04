import Foundation

public enum WhetherUnit {
    case us // crazy
    case si // default
    case uk // same as si, except that nearestStormDistance and visibility are in miles, and windSpeed and windGust in miles per hour
    case ca // same as si, except that windSpeed and windGust are in kilometers per hour
}

extension Measurement {
    public init?(value: Any?, unit: UnitType) {
        guard let value = value as? Double else { return nil }
        self.init(value: value, unit: unit)
    }

    public func description(withPrecision precision: Int? = nil) -> String {
        guard let precision = precision else { return description }
        return String(format: "%.\(precision)f %@", value, unit.symbol)
    }
}

public class UnitOzone: Dimension {
    public class var dobson: UnitOzone {
        return UnitOzone(symbol: "Dobsons", converter: UnitConverterLinear(coefficient: 1))
    }

    override public class func baseUnit() -> UnitOzone {
        return UnitOzone.dobson
    }
}

public class UnitPercent: Dimension {
    public class var double: UnitPercent {
        return UnitPercent(symbol: "of 1", converter: UnitConverterLinear(coefficient: 1))
    }

    public class var percent: UnitPercent {
        return UnitPercent(symbol: "%", converter: UnitConverterLinear(coefficient: 0.01))
    }

    override public class func baseUnit() -> UnitPercent {
        return .double
    }
}

public class UnitIntensity: Dimension {
    public class var mmPerHour: UnitIntensity {
        return UnitIntensity(symbol: "mm/hr", converter: UnitConverterLinear(coefficient: 1))
    }
    public class var inchesPerHour: UnitIntensity {
        return UnitIntensity(symbol: "in/hr", converter: UnitConverterLinear(coefficient: 25.4))
    }

    override public class func baseUnit() -> UnitIntensity {
        return UnitIntensity.mmPerHour
    }
}
