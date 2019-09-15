//
//  Alerts.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

extension WeatherReport {
    public struct Alert {
        public enum AlertSeverity: String {
            case advisory = "advisory"
            case watch = "watch"
            case warning = "warning"
            case none = "none"
        }

        public let description: String
        public let expires: Date
        public let regions: [String]
        private let severityString: String
        public var severity: AlertSeverity {
            return AlertSeverity(rawValue: severityString) ?? .none
        }
        public let time: Date
        public let title: String
        private let uriString: String
        public var url: URL? {
            return URL(string: uriString)
        }
    }
}

extension WeatherReport.Alert: Codable {
    internal enum CodingKeys: String, CodingKey {
        case description = "description"
        case expires = "expires"
        case regions = "regions"
        case severityString = "severity"
        case time = "time"
        case title = "title"
        case uriString = "uri"
    }
}
