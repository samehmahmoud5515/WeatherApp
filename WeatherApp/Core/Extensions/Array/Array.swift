//
//  Array.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import Foundation

extension Array {

    func filterDuplicates(includeElement: (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        var results = [Element]()

        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }

        return results
    }
}
