//
//  HeadlineEntity.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Foundation

struct HeadlineEntity {
    var author: String
    var title: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var articleVisited: Bool = false
}

// MARK: - Functions
extension HeadlineEntity {
    func toHeadlineModel() -> HeadlineModel {
        return HeadlineModel(
            title: title,
            publishedAt: publishedAt,
            author: author,
            urlToImage: urlToImage,
            url: url,
            articleVisited: articleVisited
        )
    }
    
    func toRealmEntity() -> HeadlineRealmObject {
        return HeadlineRealmObject(
            author: author,
            title: title,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            articleVisited: articleVisited
        )
    }
}
