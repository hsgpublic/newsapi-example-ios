//
//  ArticleViewModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation

final class ArticleViewModel {
    // MARK: Properties
    let title: String
    private let url: URL
    var urlRequest: URLRequest {
        URLRequest(url: url)
    }
    
    // MARK: Lifecycle
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
}
