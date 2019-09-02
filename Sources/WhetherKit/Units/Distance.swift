//
//  Distance.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

public class UnitDistance: Dimension {
    public class var meters: UnitDistance {
        return UnitDistance(
            symbol: UnitLength.meters.symbol,
            converter: UnitConverterLinear(coefficient: 1)
        )
    }

    public class var kilometers: UnitDistance {
        let kmUnit = UnitLength.kilometers
        return UnitDistance(
            symbol: kmUnit.symbol,
            converter: kmUnit.converter
        )
    }

    public class var miles: UnitDistance {
        let milesUnit = UnitLength.miles
        return UnitDistance(
            symbol: milesUnit.symbol,
            converter: milesUnit.converter
        )
    }

    override public class func baseUnit() -> UnitDistance {
        return UnitDistance.meters
    }
}

extension WhetherUnit {
    public typealias Distance = WhetherMeasurement<UnitDistance>
}

extension UnitDistance: WhetherUnitConvertible {
    public class func unit(for whetherUnit: WhetherUnit) -> UnitDistance {
        switch whetherUnit {
        case .us, .uk: return .miles
        default: return .kilometers
        }
    }
}

extension UnitDistance: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitDistance { return .kilometers }
}
