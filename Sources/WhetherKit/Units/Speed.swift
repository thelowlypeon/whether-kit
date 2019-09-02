//
//  Speed.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

extension WhetherUnit {
    public typealias Speed = WhetherMeasurement<UnitSpeed>
}

extension UnitSpeed: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitSpeed { return .metersPerSecond }
}

extension UnitSpeed: WhetherUnitConvertible {
    public class func unit(for whetherUnit: WhetherUnit) -> UnitSpeed {
        switch whetherUnit {
        case .us, .uk: return .milesPerHour
        case .ca: return .kilometersPerHour
        default: return .metersPerSecond
        }
    }
}
