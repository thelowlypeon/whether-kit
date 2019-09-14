//
//  Requests.swift
//  SimpleNetworking
//
//  Created by Peter Compernolle on 9/7/19.
//

import Foundation
import SimpleNetworking

extension Whether {
    public struct Location {
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

    public enum WeatherRequestResult {
        case success(WeatherReport)
        case failure(WhetherError)
    }

    public typealias WeatherRequestCompletionHandler = (WeatherRequestResult) -> Void

    public func weather(at location: Location, _ callback: @escaping WeatherRequestCompletionHandler) {
        manager.get(location.path) {(request) in
            return request.accept(.json)
                .on(httpStatus: 401, {(req, _) in
                    if req.retries > 0 {
                        return true
                    } else {
                        self.authenticate {(res) in
                            switch res {
                            case .success:
                                req.retry(on: self.manager)
                            case .failure(let error):
                                callback(.failure(error))
                            }
                        }
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
