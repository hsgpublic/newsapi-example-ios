//
//  HeadlineRealmEntity.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Foundation
import RealmSwift

final class HeadlineRealmEntity: Object, HeadlineEntityable {
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
extension HeadlineRealmEntity {
    func toHeadlineEntity() -> HeadlineEntity {
        HeadlineEntity(
            author: author,
            title: title,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt
        )
    }
}
