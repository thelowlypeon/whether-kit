//
//  Preferences.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/21/19.
//

import Foundation
import SimpleNetworking

@available(iOS 10, macOS 10.12, *)
extension Whether {
    internal enum WhetherPreferencesRequestResult {
        case success([WhetherPreference])
        case failure(WhetherError)
    }

    internal typealias WhetherPreferencesRequestCompletionHandler = (WhetherPreferencesRequestResult) -> Void

    internal func preferences(_ callback: @escaping WhetherPreferencesRequestCompletionHandler) {
        manager.get("/preferences") {(request) in
            return request.accept(.json)
                .on(error: {(error) in
                    callback(.failure(WhetherError.from(simpleNetworkingError: error)))
                })
                .on(success: {(response) in
                    if let preferences: [WhetherPreference] = response.decodeJSON(using: self.decoder) {
                        callback(.success(preferences))
                    } else {
                        callback(.failure(.invalidResponse))
                    }
                })
        }
    }
}
