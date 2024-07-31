//
//  HeadlineEntity.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation
import RealmSwift

final class HeadlineEntity: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: String
    @Persisted var title: String
    @Persisted var url: String
    @Persisted var urlToImage: String
    @Persisted var publishedAt: String
    
    // MARK: Lifecycle
    convenience init(author: String, title: String, url: String, urlToImage: String, publishedAt: String) {
        self.init()
        
        self.author = author
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}

// MARK: - Functions
extension HeadlineEntity {
    func toHeadlineModel() -> HeadlineModel {
        return HeadlineModel(
            title: title,
            publishedAt: publishedAt,
            author: author,
            urlToImage: urlToImage,
            url: url
        )
    }
}
