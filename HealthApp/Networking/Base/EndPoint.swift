//
//  EndPoint.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var url: URL? { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var queries: [String: String]? { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var header: [String: String]? { nil }
    var body: [String: Any]? { nil }
    var queries: [String: String]? { nil }
    var method: HTTPMethod { .get }
}
