//
//  AccessTokenAuthorizable.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol AccessTokenAuthorizable {
    var authorizationType: AuthorizationType { get }
}

// MARK: - AuthorizationType

public enum AuthorizationType {
    /// No header.
    case none

    /// The `"Basic"` header.
    case basic

    /// The `"Bearer"` header.
    case bearer

    /// Custom header implementation.
    case custom(String)

    public var value: String? {
        switch self {
        case .none: return nil
        case .basic: return "Basic"
        case .bearer: return "Bearer"
        case let .custom(customValue): return customValue
        }
    }
}

extension AccessTokenAuthorizable {
    var authentications: [String: String] {
        switch authorizationType {
        case .custom:
            return [:]
        case .none:
            return [:]
        case .basic:
            return ["Authorization": "Basic aW9zOmlvc1BBYXNzd2Q="]
        case .bearer:
            return ["Authorization": "Bearer "]
        }
    }
}
