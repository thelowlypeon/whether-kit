//
//  Percent.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

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

extension UnitPercent: WhetherUnitConvertible {
    public static func unit(for whetherUnit: WhetherUnit) -> UnitPercent {
        return .percent
    }
}

extension WhetherUnit {
    public typealias Percent = WhetherMeasurement<UnitPercent>
}

extension UnitPercent: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitPercent {
        return baseUnit()
    }
}

extension WhetherUnit.Percent {
    public init?(value: Double) {
        guard value >= 0.0 && value <= 1.0 else { return nil }
        self.init(value: value)
    }
}
