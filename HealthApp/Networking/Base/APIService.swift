//
//  APIService.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case error(Error)
}

protocol APIService {
    func makeRequest<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

extension APIService {
    func makeRequest<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if let json = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.error(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                print(error)
                completion(.failure(.error(error)))
            }
        }

        task.resume()
    }
}
