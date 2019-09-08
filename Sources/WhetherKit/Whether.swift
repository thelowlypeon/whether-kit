//
//  Whether.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/4/19.
//

import Foundation
import SimpleNetworking

fileprivate var _sharedInstance: Whether!
public struct Whether {
    internal let manager: SimpleNetworking

    public static var shared: Whether {
        if _sharedInstance == nil {
            _sharedInstance = Whether(
                manager: SimpleNetworking(baseURL: URL(string: "https://thewhetherapp.herokuapp.com/api/")!)
            )
        }
        return _sharedInstance
    }
}
