//
//  WhetherPreference.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/21/19.
//

@available(iOS 10, macOS 10.12, *)
public struct WhetherPreference {
    public let good: Bool
    public let activityType: String
    public let snapshot: WeatherReport.Currently.Snapshot
}

@available(iOS 10, macOS 10.12, *)
extension WhetherPreference: Codable {
    internal enum CodingKeys: String, CodingKey {
        case good
        case activityType = "activity_type"
        case snapshot
    }
}
