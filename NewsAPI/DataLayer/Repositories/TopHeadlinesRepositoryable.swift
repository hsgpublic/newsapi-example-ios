//
//  TopHeadlinesRepositoryable.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/2/24.
//

import Foundation
import Combine

protocol TopHeadlinesRepositoryable {
    var networkErrorSubject: PassthroughSubject<Error, Never> { get }
    var headlinesPublisher: AnyPublisher<[HeadlineModel], Never> { get }
    func fetchTopHeadlines(country: String)
    func markVisited(index: Int)
}
