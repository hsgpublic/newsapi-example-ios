//
//  HeadlineEntity.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Foundation

struct HeadlineEntity: HeadlineEntityable {
    var author: String
    var title: String
    var url: String
    var urlToImage: String
    var publishedAt: String
}

// MARK: - Functions
extension HeadlineEntity {
    func toRealmEntity() -> HeadlineRealmEntity {
        HeadlineRealmEntity(
            author: author,
            title: title,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt
        )
    }
}
