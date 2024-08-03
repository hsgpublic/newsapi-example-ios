//
//  ArticleResponseModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

struct ArticleResponseModel: Decodable {
    let source: SourceResponseModel?
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
    // MARK: Constants
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    // MARK: Lifecycle
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.source = try container.decodeIfPresent(SourceResponseModel.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}

// MARK: - Functions
extension ArticleResponseModel {
    func toHeadlineEntity() -> HeadlineEntity {
        return HeadlineEntity(
            author: author,
            title: title,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt
        )
    }
}
