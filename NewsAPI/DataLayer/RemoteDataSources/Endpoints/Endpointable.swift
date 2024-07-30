//
//  Endpointable.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

enum EndpointScheme: String {
    case http
    case https
}

enum EndpointMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpointable {
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
