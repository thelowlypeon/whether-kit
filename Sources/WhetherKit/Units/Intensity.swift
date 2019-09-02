//
//  Intensity.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

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

extension UnitIntensity: WhetherUnitConvertible {
    public static func unit(for whetherUnit: WhetherUnit) -> UnitIntensity {
        switch whetherUnit {
        case .us: return .inchesPerHour
        default: return .mmPerHour
        }
    }
}

extension UnitIntensity: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitIntensity { return .mmPerHour }
}

extension WhetherUnit {
    public typealias Intensity = WhetherMeasurement<UnitIntensity>
}
