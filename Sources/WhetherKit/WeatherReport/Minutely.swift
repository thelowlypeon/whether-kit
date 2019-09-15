//
//  Minutely.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

extension WeatherReport {
    public class SnapshotMinutely: WhetherSnapshotType {}
    public struct Minutely {
        public let summary: String?
        public let icon: String?
        public let data: [WeatherReport.Snapshot<SnapshotMinutely>]
    }
}

extension WeatherReport.Minutely: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
}
