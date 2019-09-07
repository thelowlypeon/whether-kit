//
//  Requests.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/7/19.
//

import Foundation
import SimpleNetworking

public struct WhetherLocation {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public init(_ latitude: Double, _ longitude: Double) {
        self.init(latitude: latitude, longitude: longitude)
    }

    internal var path: String {
        return "/\(latitude),\(longitude)"
    }
}

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
        case .clientError(_):
            return .authorizationFailure
        default:
            return .serverError
        }
    }
}

public enum WeatherRequestResult {
    case success(WeatherReport)
    case failure(WhetherError)
}

public typealias WeatherRequestCompletionHandler = (WeatherRequestResult) -> Void

extension Whether {
    private struct Authentication: Decodable {
        let token: String

        enum CodingKeys: String, CodingKey {
            case token = "token"
        }
    }

    private func authenticate(with auth: Authentication?) {
        self.manager.defaultHeaders["X-Authorization"] = auth?.token
    }

    internal func authenticate(_ callback: @escaping (WhetherError?) -> Void) {
        manager.get("/auth") {(request) in
            return request.accept(.json)
                .on(httpStatus: 403, {(_, _) in
                    callback(.rateLimitExceeded)
                    return false
                })
                .on(error: {(_) in
                    callback(.authorizationFailure)
                })
                .on(success: {(response) in
                    self.authenticate(with: response.decodeJSON())
                    callback(nil)
                })
        }
    }

    internal func authenticateThenRetry(request: SimpleRequest, callback: @escaping WeatherRequestCompletionHandler) {
        authenticate {(error) in
            if let error = error {
                callback(.failure(error))
            } else {
                request.retry(on: self.manager) }
        }
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    public func weather(at location: WhetherLocation, _ callback: @escaping WeatherRequestCompletionHandler) {
        var retriedAfterAuthentication = false
        manager.get(location.path) {(request) in
            return request.accept(.json)
                .on(httpStatus: 401, {(req, _) in
                    if retriedAfterAuthentication {
                        return true
                    } else {
                        retriedAfterAuthentication = true
                        self.authenticateThenRetry(request: req, callback: callback)
                        return false
                    }
                })
                .on(error: {(error) in
                    callback(.failure(WhetherError.from(simpleNetworkingError: error)))
                })
                .on(success: {(response) in
                    if let report: WeatherReport = response.decodeJSON(using: self.decoder) {
                        callback(.success(report))
                    } else {
                        callback(.failure(.invalidResponse))
                    }
                })
        }
    }
}
