//
//  HeadlineRealmEntity.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Foundation
import RealmSwift

final class HeadlineRealmObject: Object {
    @Persisted(primaryKey: true) var compositeKey: String
    @Persisted var author: String
    @Persisted var title: String
    @Persisted var url: String
    @Persisted var urlToImage: String
    @Persisted var publishedAt: String
    @Persisted var articleVisited: Bool
    
    // MARK: Lifecycle
    convenience init(
        author: String,
        title: String,
        url: String,
        urlToImage: String,
        publishedAt: String,
        articleVisited: Bool
    ) {
        self.init()
        
        compositeKey = HeadlineRealmObject.makeCompositeKey(
            publishedAt: publishedAt,
            author: author
        )
        self.author = author
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.articleVisited = articleVisited
    }
    
    class func makeCompositeKey(publishedAt: String, author: String) -> String {
        return "\(publishedAt)-\(author)"
    }
}

// MARK: - Functions
extension HeadlineRealmObject {
    func toHeadlineEntity() -> HeadlineEntity {
        return HeadlineEntity(
            author: author,
            title: title,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            articleVisited: articleVisited
        )
    }
}
