//
//  TopHeadlinesResponseModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

struct TopHeadlinesResponseModel: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        self.articles = try container.decodeIfPresent([ArticleResponseModel].self, forKey: .articles) ?? []
    }
}
