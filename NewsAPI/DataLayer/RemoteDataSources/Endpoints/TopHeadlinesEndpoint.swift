//
//  TopHeadlinesEndpoint.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

struct TopHeadlinesEndpoint: Endpointable {
    private let _query: [String: String]
    
    var path: String {
        "/v2/top-headlines"
    }
    var query: [String : String] {
        _query
    }
    var headers: [String : String] {
        [
            "Content-Type": EndpointContentType.applicationJson.rawValue
        ]
    }
    var method: EndpointMethod {
        .get
    }
    
    init(country: String) {
        _query = [
            "country": country
        ]
    }
}
