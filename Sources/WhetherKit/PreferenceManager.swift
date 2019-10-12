//
//  PreferenceManager.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 10/12/19.
//

import Foundation

@available(iOS 10, macOS 10.12, *)
public class PreferenceManager {
    private let archiveURL: URL

    internal func loadPreferences() throws -> [WhetherPreference]? {
        let data = try Data(contentsOf: archiveURL)
        return try PropertyListDecoder().decode([WhetherPreference].self, from: data)
    }

    public var preferences = [WhetherPreference]()

    internal init(filePath: String? = nil, restore: Bool? = true) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        archiveURL = documentsDirectory.appendingPathComponent(filePath ?? "preferences")

        if restore == true {
            if let archivedPreferences = try? loadPreferences() {
                self.preferences = archivedPreferences!
            }
        }
    }

    public func log(_ preference: WhetherPreference) throws {
        preferences.append(preference)
        try persist()
    }

    private func persist() throws {
        let data = try PropertyListEncoder().encode(preferences)
        try data.write(to: archiveURL)
    }
}
