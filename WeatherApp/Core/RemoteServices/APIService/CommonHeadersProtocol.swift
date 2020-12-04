//
//  CommonHeadersProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol CommonHeadersProtocol {
    var commonHeaders: [String: String] { get }
}

extension CommonHeadersProtocol {
    var commonHeaders: [String: String] {
        var params = [String: String]()
        params += ["Content-Type": "application/json"]
        params += ["Accept": "application/json"]
        return params
    }
}
