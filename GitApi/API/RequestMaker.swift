//
//  RequestMaker.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

typealias RequestCallback<T> = (Result<T, APIError>) -> Void

protocol URLProvider {
    var url: String { get }
}

protocol RequestMaker {
    associatedtype Endpoint: URLProvider
    var apiBase: String { get }

    func request<T: Decodable>(with: Endpoint, completion: @escaping RequestCallback<T>)
}

extension RequestMaker {

    func request<T: Decodable>(with endpoint: Endpoint, completion: @escaping RequestCallback<T>) {
        let urlString = "\(apiBase)/\(endpoint.url)"

        guard let url = URL(string: urlString) else {
            completion(.failure(.malformedURL))
            return
        }

        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let values = try decoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }.resume()
    }
}

struct APIRequestMaker: RequestMaker {
    typealias Endpoint = GitHubEndpoints

    let apiBase: String = "https://api.github.com"

    enum GitHubEndpoints: URLProvider {
        case list(language: String, page: Int)

        var url: String {
            switch self {
            case .list(let language, let page):
                return "search/repositories?q=language:\(language)&sort=stars&page=\(page)&per_page=100"
            }
        }
    }
}
