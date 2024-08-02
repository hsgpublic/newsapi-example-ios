//
//  TopHeadlinesRepository.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation
import Combine

final class TopHeadlinesRepository: TopHeadlinesRepositoryable {
    // MARK: Properties
    private let remoteDataSource: TopHeadlinesRemoteDataSourceable
    private var topHeadlinesCancellable: AnyCancellable?
    
    // MARK: Observables
    let networkErrorSubject = PassthroughSubject<Error, Never>()
    var headlinesPublisher: AnyPublisher<[HeadlineModel], Never> {
        headlinesSubject.eraseToAnyPublisher()
    }
    private let headlinesSubject = CurrentValueSubject<[HeadlineModel], Never>([])
    
    // MARK: Lifecycle
    init(remoteDataSource: TopHeadlinesRemoteDataSourceable = TopHeadlinesRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: Functions
    func fetchTopHeadlines(country: String) {
        topHeadlinesCancellable?.cancel()
        topHeadlinesCancellable = remoteDataSource.getTopHeadlines(country: country)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.networkErrorSubject.send(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] topHeadlines in
                let headlines = topHeadlines.articles
                    .map { article in
                        HeadlineModel(
                            title: article.title,
                            publishedAt: article.publishedAt,
                            author: article.author,
                            urlToImage: article.urlToImage,
                            url: article.url
                        )
                    }
                self?.headlinesSubject.send(headlines)
            }
    }
}
