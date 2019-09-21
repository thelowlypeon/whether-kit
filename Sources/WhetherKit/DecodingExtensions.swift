//
//  Extensions.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/20/19.
//

import Foundation

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
