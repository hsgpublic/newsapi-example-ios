//
//  Endpointable.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

enum EndpointScheme: String {
    case https
}

enum EndpointMethod: String {
    case get = "GET"
}

enum EndpointContentType: String {
    case applicationJson = "application/json"
}

protocol Endpointable {
    var url: URL? { get }
    var urlString: String { get }
    var scheme: EndpointScheme { get }
    var host: String { get }
    var port: Int { get }
    var path: String { get }
    var baseQuery: [String: String] { get }
    var query: [String:String] { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var method: EndpointMethod { get }
}

extension Endpointable {
    var url: URL? {
        let mergedQuery = baseQuery.merging(query, uniquingKeysWith: { $1 })
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = mergedQuery.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        return components.url
    }
    var urlString: String {
        "\(scheme)://\(host)\(path)" + (query.isEmpty ? "" : "?\(query)")
    }
    var scheme: EndpointScheme {
        ServerConfig.scheme
    }
    var host: String {
        ServerConfig.httpHost
    }
    var port: Int {
        ServerConfig.httpPort
    }
    var baseQuery: [String: String] {
        [
            "apiKey": ServerConfig.apiKey
        ]
    }
    var query: [String:String] {
        [:]
    }
    var headers: [String: String] {
        [:]
    }
    var parameters: [String: Any] {
        [:]
    }
    var method: EndpointMethod {
        .get
    }
}
