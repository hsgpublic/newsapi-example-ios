//
//  ArticleViewModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation

final class ArticleViewModel {
    // MARK: Properties
    private let urlString: String
    var url: URL? {
        URL(string: urlString)
    }
    
    // MARK: Lifecycle
    init(urlString: String) {
        self.urlString = urlString
    }
}
