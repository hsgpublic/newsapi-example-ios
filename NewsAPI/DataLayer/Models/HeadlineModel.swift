//
//  HeadlineModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation

struct HeadlineModel {
    let title: String
    let publishedAt: String
    let author: String
    let urlToImage: String
    let url: String
    var articleVisited: Bool = false
}

// MARK: - Functions
extension HeadlineModel {
    func toHeadlineEntity() -> HeadlineEntity {
        HeadlineEntity(
            author: author,
            title: title,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            articleVisited: articleVisited
        )
    }
}
