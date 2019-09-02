//
//  Ozone.swift
//  WhetherKit
//
//  Created by Peter Compernolle on 9/2/19.
//

import Foundation

public class UnitOzone: Dimension {
    public class var dobson: UnitOzone {
        return UnitOzone(symbol: "Dobsons")
    }
    override public class func baseUnit() -> UnitOzone {
        return UnitOzone.dobson
    }
}

extension WhetherUnit {
    public typealias Ozone = WhetherMeasurement<UnitOzone>
}


extension UnitOzone: MeasurementWithDefaultUnit {
    public static var defaultUnit: UnitOzone { return UnitOzone.dobson }
}
