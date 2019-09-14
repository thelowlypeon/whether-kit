//
//  AuthenticationManager.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/8/19.
//

import Foundation
import SimpleNetworking


public protocol WhetherCredentialStorage {
    func restore() -> Whether.Credentials?
    func persist(credentials: Whether.Credentials?)
}

extension Whether {
    public struct Credentials: Codable {
        let token: String

        enum CodingKeys: String, CodingKey {
            case token = "token"
        }
    }

    public struct CredentialStorageUserDefaults: WhetherCredentialStorage {
        private static let keyPath = "_whether__temporary_credentials"

        public static var standard: CredentialStorageUserDefaults {
            return CredentialStorageUserDefaults(userDefaults: UserDefaults.standard)
        }

        public let userDefaults: UserDefaults

        public func restore() -> Credentials? {
            guard let data = userDefaults.data(forKey: CredentialStorageUserDefaults.keyPath) else { return nil }
            return try? JSONDecoder().decode(Credentials.self, from: data)
        }

        public func persist(credentials: Credentials?) {
            if let credentials = credentials {
                guard let data = try? JSONEncoder().encode(credentials) else { return }
                userDefaults.set(data, forKey: CredentialStorageUserDefaults.keyPath)
            } else {
                userDefaults.removeObject(forKey: CredentialStorageUserDefaults.keyPath)
            }
        }
    }

    public typealias AuthenticationCompletionHandler = (AuthenticationResult) -> Void

    public enum AuthenticationResult {
        case success
        case failure(WhetherError)
    }

    internal func authenticate(with credentials: Credentials?, persist: Bool? = nil) {
        manager.defaultHeaders["X-Authorization"] = credentials?.token
        if persist ?? true {
            credentialStorage.persist(credentials: credentials)
        }
    }

    public func authenticate(_ callback: @escaping AuthenticationCompletionHandler) {
        manager.get("/auth") {(request) in
            return request.accept(.json)
                .on(httpStatus: 403, {(_, _) in
                    callback(.failure(.rateLimitExceeded))
                    return false
                })
                .on(error: {(_) in
                    callback(.failure(.authorizationFailure))
                })
                .on(success: {(response) in
                    if let credentials: Credentials = response.decodeJSON() {
                        self.authenticate(with: credentials)
                        callback(.success)
                    } else {
                        self.authenticate(with: nil)
                        callback(.failure(.authorizationFailure))
                    }
                })
        }
    }
}
