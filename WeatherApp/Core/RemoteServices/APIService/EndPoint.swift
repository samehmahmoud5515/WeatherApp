//
//  EndPoint.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol EndPoint: EnvironmentProtocol, AccessTokenAuthorizable, CommonHeadersProtocol {
    var baseUrl: String { get }

    var path: String { get }

    var queryParameters: [String: String?] { get }

    var headers: [String: String] { get }

    var method: RequestHTTPMethod { get }

    var bodyParmaters: [String: Any?] { get }

}

extension EndPoint {
    var urlRequest: URLRequest {
        var urlStr: String = ""

        urlStr.append(baseUrl)

        urlStr.append(path)

        var url = URL(string: urlStr)!

        var queryParamters = [URLQueryItem]()

        for parameter in queryParameters {
            if let value = parameter.value {
                queryParamters.append(URLQueryItem(name: parameter.key, value: value))
            }
        }

        if let urlWithQueryParamter = url.appending(queryParamters) {
            url = urlWithQueryParamter
        }

        var request: URLRequest = URLRequest(url: url)

        request.httpMethod = method.rawValue

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        for header in commonHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        for header in authentications {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParmaters, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {
                print(error)
            }
        }

        return request
    }
}
