//
//  Temperature.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

extension WhetherUnit {
    public typealias Temperature = WhetherMeasurement<UnitTemperature>
}

extension UnitTemperature: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitTemperature { return .celsius }
}

extension UnitTemperature: WhetherUnitConvertible {
    public class func unit(for whetherUnit: WhetherUnit) -> UnitTemperature {
        switch whetherUnit {
        case .us: return .fahrenheit
        default: return .celsius
        }
    }
}
