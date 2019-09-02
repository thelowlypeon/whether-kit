//
//  Pressure.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

extension WhetherUnit {
    public typealias Pressure = WhetherMeasurement<UnitPressure>
}

extension UnitPressure: WhetherUnitConvertible {
    public static func unit(for whetherUnit: WhetherUnit) -> UnitPressure {
        switch whetherUnit {
            case .us: return .millibars
            default: return .hectopascals
        }
    }
}

extension UnitPressure: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitPressure { return .hectopascals }
}
