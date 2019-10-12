//
//  CodingExtensions.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/20/19.
//

import Foundation

@available(iOS 10, macOS 10.12, *)
extension KeyedEncodingContainer {
    internal mutating func encodeTemperature(_ temperature: Measurement<UnitTemperature>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(temperature?.converted(to: .celsius).value, forKey: key)
    }

    internal mutating func encodeSpeed(_ speed: Measurement<UnitSpeed>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(speed?.converted(to: .metersPerSecond).value, forKey: key)
    }

    internal mutating func encodeAngle(_ angle: Measurement<UnitAngle>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(angle?.converted(to: .degrees).value, forKey: key)
    }

    internal mutating func encodeLength(_ distance: Measurement<UnitLength>?, forKey key: KeyedEncodingContainer.Key, unit: UnitLength? = nil) throws {
        try encodeIfPresent(distance?.converted(to: unit ?? .kilometers).value, forKey: key)
    }

    internal mutating func encodePercent(_ percent: Measurement<UnitPercent>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(percent?.converted(to: .double).value, forKey: key)
    }

    internal mutating func encodePressure(_ pressure: Measurement<UnitPressure>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(pressure?.converted(to: .hectopascals).value, forKey: key)
    }

    internal mutating func encodeOzone(_ ozone: Measurement<UnitOzone>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(ozone?.converted(to: .dobson).value, forKey: key)
    }

    internal mutating func encodePrecipitationType(_ precipitationType: WeatherReport.PrecipitationType?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(precipitationType?.rawValue, forKey: key)
    }

    internal mutating func encodeIntensity(_ intensity: Measurement<UnitIntensity>?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(intensity?.converted(to: .mmPerHour).value, forKey: key)
    }

    internal mutating func encodeSnapshotIcon(_ snapshotIcon: WeatherReport.Icon?, forKey key: KeyedEncodingContainer.Key) throws {
        try encodeIfPresent(snapshotIcon?.rawValue, forKey: key)
    }
}

@available(iOS 10, macOS 10.12, *)
extension KeyedDecodingContainer {
    internal func decodeTemperature(forKey key: KeyedDecodingContainer.Key, unit: UnitTemperature? = nil) throws -> Measurement<UnitTemperature>? {
        return Measurement<UnitTemperature>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .celsius
        )
    }

    internal func decodeSpeed(forKey key: KeyedDecodingContainer.Key, unit: UnitSpeed? = nil) throws -> Measurement<UnitSpeed>? {
        return Measurement<UnitSpeed>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .metersPerSecond
        )
    }

    internal func decodeAngle(forKey key: KeyedDecodingContainer.Key, unit: UnitAngle? = nil) throws -> Measurement<UnitAngle>? {
        return Measurement<UnitAngle>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .degrees
        )
    }

    internal func decodeLength(forKey key: KeyedDecodingContainer.Key, unit: UnitLength? = nil) throws -> Measurement<UnitLength>? {
        return Measurement<UnitLength>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .kilometers
        )
    }

    internal func decodePercent(forKey key: KeyedDecodingContainer.Key, unit: UnitPercent? = nil) throws -> Measurement<UnitPercent>? {
        return Measurement<UnitPercent>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .double
        )
    }

    internal func decodePressure(forKey key: KeyedDecodingContainer.Key, unit: UnitPressure? = nil) throws -> Measurement<UnitPressure>? {
        return Measurement<UnitPressure>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .hectopascals
        )
    }

    internal func decodeOzone(forKey key: KeyedDecodingContainer.Key, unit: UnitOzone? = nil) throws -> Measurement<UnitOzone>? {
        return Measurement<UnitOzone>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .dobson
        )
    }

    internal func decodeIntensity(forKey key: KeyedDecodingContainer.Key, unit: UnitIntensity? = nil) throws -> Measurement<UnitIntensity>? {
        return Measurement<UnitIntensity>(
            value: try self.decodeIfPresent(Double.self, forKey: key),
            unit: unit ?? .mmPerHour
        )
    }

    internal func decodePrecipitationType(forKey key: KeyedDecodingContainer.Key) throws -> WeatherReport.PrecipitationType? {
        return WeatherReport.PrecipitationType(
            rawValue: try self.decodeIfPresent(String.self, forKey: key) ?? "unknown"
        )
    }

    internal func decodeSnapshotIcon(forKey key: KeyedDecodingContainer.Key) throws -> WeatherReport.Icon? {
        return WeatherReport.Icon(
            rawValue: try self.decodeIfPresent(String.self, forKey: key) ?? "unknown"
        )
    }
}
