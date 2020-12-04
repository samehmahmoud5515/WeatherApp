//
//  Dictionary.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

public func += <KeyType, ValueType>(left: inout [KeyType: ValueType], right: [KeyType: ValueType]) {
    for (key, value) in right {
        left.updateValue(value, forKey: key)
    }
}
