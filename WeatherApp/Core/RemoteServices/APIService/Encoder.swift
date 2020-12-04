//
//  Encoder.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol Encoder {}

extension Encoder {
    func encodeModel<T>(model: T) -> [String: Any] where T: Encodable {
        let data = try? JSONEncoder().encode(model)
        do {
            return try (JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]) ?? [:]
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}
