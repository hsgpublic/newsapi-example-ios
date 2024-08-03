//
//  HeadlineEntityable.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Foundation

protocol HeadlineEntityable {
    var author: String { get set }
    var title: String { get set }
    var url: String { get set }
    var urlToImage: String { get set }
    var publishedAt: String { get set }
}
