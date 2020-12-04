//
//  APIService.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

class APIService<T> where T: EndPoint {}

extension APIService {
    func sendRequest<R: Codable>(target: T, completion: ((Result<R, Error>) -> Void)?) {
        URLSession.shared.dataTask(with: target.urlRequest) { data, response, error in
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }

            if let status = (response as? HTTPURLResponse)?.statusCode, status == 401 {
                completion?(Result.failure(WAError.authentication))
                return
            }

            if let eaError = (error as NSError?)?.toWAError {
                completion?(Result.failure(eaError))
                return
            }

            guard let data = data else {
                completion?(Result.failure(error ?? WAError.unknown))
                return
            }

            guard let responseModel = try? JSONDecoder().decode(R.self, from: data) else {
                completion?(Result.failure(WAError.parsing))
                return
            }

            completion?(Result.success(responseModel))

        }.resume()
    }
}
