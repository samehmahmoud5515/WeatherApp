//
//  EAError.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

enum WAError: Error {
    case unknown
    case parsing
    case business(message: String)
    case emptyResults

    case internet
    case connection
    case timedout

    case authentication

    case notModified

    case server
    case parsingResponse(message: String)

    case badRequest(message: String)
    case underlying(code: Int, message: String)
    case http(code: Int)
    case database(message: String)
}

extension NSError {
    var toWAError: WAError {
        let code = URLError.Code(rawValue: self.code)

        switch code {
        case .notConnectedToInternet:
            return .internet
        case .timedOut:
            return .timedout
        case .networkConnectionLost:
            return .connection
        case .cannotConnectToHost:
            return .server
        case .userAuthenticationRequired:
            return .authentication
        case .badServerResponse, .cannotParseResponse, .cannotDecodeRawData, .cannotDecodeContentData:
            return .parsingResponse(message: "\(code): \(localizedDescription)")
        case .badURL, .unsupportedURL:
            return .badRequest(message: "\(code): Endpoint failed to encode the parameters for the URLRequest: \(localizedDescription)")
        default:
            return .underlying(code: code.rawValue, message: "\(code): \(localizedDescription)")
        }
    }
}
