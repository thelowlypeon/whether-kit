//
//  Whether.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/4/19.
//

import Foundation
import SimpleNetworking

public enum WhetherError {
    case invalidResponse
    case networkingError(Error?)
    case invalidURL
    case rateLimitExceeded
    case authorizationFailure
    case serverError

    internal static func from(simpleNetworkingError error: SimpleNetworkingError) -> WhetherError {
        switch error {
        case .invalidURL:
            return .invalidURL
        case .networkingError(let error):
            return .networkingError(error)
        case .clientError(let status):
            switch status {
            case 403: return .rateLimitExceeded
            default: return .authorizationFailure
            }
        default:
            return .serverError
        }
    }
}

fileprivate var _sharedInstance: Whether!
public struct Whether {
    internal let manager: SimpleNetworking
    internal let credentialStorage: WhetherCredentialStorage

    internal var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    public static var defaultNetworkingManager: SimpleNetworking {
        return SimpleNetworking(baseURL: URL(string: "https://thewhetherapp.herokuapp.com/api")!)
    }

    public static var localNetworkingManager: SimpleNetworking {
        return SimpleNetworking(baseURL: URL(string: "http://localhost:9292/api")!)
    }

    public static var shared: Whether {
        if _sharedInstance == nil {
            _sharedInstance = Whether(
                manager: Whether.defaultNetworkingManager,
                credentialStorage: CredentialStorageUserDefaults.standard
            )
        }
        return _sharedInstance
    }

    public init(manager: SimpleNetworking, credentialStorage: WhetherCredentialStorage) {
        self.manager = manager
        self.credentialStorage = credentialStorage
        self.authenticate(with: credentialStorage.restore(), persist: false)
    }

    internal func setAuthenticationHeader(with credentials: Credentials?) {
        manager.defaultHeaders["X-Authorization"] = credentials?.token
    }
}
