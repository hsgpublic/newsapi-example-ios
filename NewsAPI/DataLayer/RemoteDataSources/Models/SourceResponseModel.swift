//
//  SourceResponseModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

struct SourceResponseModel: Decodable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url
        case category
        case language
        case country
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
}
