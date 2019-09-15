//
//  Daily.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

// TODO: DAILY STUFF
//        private let apparentTemperatureHighCelsius: Double?
//        public let apparentTemperatureHighTime: Date?
//        private let apparentTemperatureLowCelsius: Double?
//        public let apparentTemperatureLowTime: Date?
//        private let apparentTemperatureMaxCelsius: Double?
//        public let apparentTemperatureMaxTime: Date?
//        private let apparentTemperatureMinCelsius: Double?
//        public let apparentTemperatureMinTime: Date?

//        private let moonPhaseDouble: Double? // percent with 0 new moon, 0.5 full moon, etc
//
//        private let precipAccumulationMillimeters: Double?
//        private let precipIntensityMaxMillimetersPerHour: Double?
//        public let precipIntensityMaxTime: Date?
//        public let sunriseTime: Date?
//        public let sunsetTime: Date?
//
//        private let temperatureHighCelsius: Double?
//        public let temperatureHighTime: Date?
//        private let temperatureLowCelsius: Double?
//        public let temperatureLowTime: Date?

extension WeatherReport {
    public class SnapshotDaily: SnapshotDetailed {}
    public struct Daily {
        public let summary: String?
        public let icon: String?
        public let data: [WeatherReport.Snapshot<SnapshotDaily>]
    }
}

extension WeatherReport.Daily: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
}
