//
//  CardinalDirection.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

extension UnitAngle: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitAngle { return .degrees }
}

extension WhetherUnit {
    public typealias CardinalDirection = WhetherMeasurement<UnitAngle>
}

extension UnitAngle: WhetherUnitConvertible {
    public static func unit(for whetherUnit: WhetherUnit) -> UnitAngle {
        return .degrees
    }
}
