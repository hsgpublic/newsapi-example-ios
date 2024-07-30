//
//  ServerConfig.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

final class ServerConfig {
    private init() { }
    
    static let scheme: EndpointScheme = .https
    static let httpHost: String = "newsapi.org"
    static let httpPort: Int = 443
    static let apiKey: String = "2e12b43094ad4aec976d468955b76d60"
}
