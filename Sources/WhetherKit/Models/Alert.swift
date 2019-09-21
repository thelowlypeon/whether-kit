//
//  Alerts.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

@available(iOS 10, macOS 10.12, *)
extension WeatherReport {
    public struct Alert {
        public enum AlertSeverity: String {
            case advisory
            case watch
            case warning
            case none
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

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Alert: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case description
        case expires
        case regions
        case severityString
        case time
        case title
        case uriString
    }
}
