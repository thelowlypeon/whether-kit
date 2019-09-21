//
//  Minutely.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/15/19.
//

import Foundation

@available(iOS 10, macOS 10.12, *)
extension WeatherReport {
    public struct Minutely {
        public let summary: String?
        public let icon: String?
        public let data: [WeatherReport.Minutely.Snapshot]
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Minutely: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Minutely {
    public struct Snapshot {
        let time: Date
        let precipIntensity: Measurement<UnitIntensity>?
        let precipProbability: Measurement<UnitPercent>?
        let precipIntensityError: Measurement<UnitPercent>?
    }
}

@available(iOS 10, macOS 10.12, *)
extension WeatherReport.Minutely.Snapshot: Decodable {
    enum CodingKeys: String, CodingKey {
        case time
        case precipIntensity
        case precipProbability
        case precipIntensityError
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.time = try container.decode(Date.self, forKey: .time)
        self.precipProbability = try container.decodePercent(forKey: .precipProbability)
        self.precipIntensity = try container.decodeIntensity(forKey: .precipIntensity)
        self.precipIntensityError = try container.decodePercent(forKey: .precipIntensityError)
    }
}
