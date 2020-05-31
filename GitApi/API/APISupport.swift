//
//  APISupport.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case malformedURL
    case apiError
    case invalidResponse
    case noData
    case decodeError
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error 1 - :\(error.localizedDescription)")
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                print("error 2 - :\(error.localizedDescription)")
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
