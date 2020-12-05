//
//  ForecastEndpoint.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

enum ForecastEndpoint {
    case forecast(city: String)
}

extension ForecastEndpoint: EndPoint {
    var path: String {
        "forecast"
    }
    
    var queryParameters: [String : String?] {
        var params = [String : String?]()
        
        switch self {
        case let .forecast(city):
            params += ["q": city]
            params += ["appid": weatherAPIKey]
            params += ["units": "metric"]
        }
        return params
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var method: RequestHTTPMethod {
        .get
    }
    
    var bodyParmaters: [String : Any?] {
        [:]
    }
    
    var authorizationType: AuthorizationType {
        .basic
    }    
}
