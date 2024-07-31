//
//  TopHeadlinesRepository.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation
import Combine

final class TopHeadlinesRepository {
    // MARK: Properties
    private let remoteDataSource: TopHeadlinesRemoteDataSource
    private var topHeadlinesCancellable: AnyCancellable?
    
    // MARK: Observables
    let networkErrorSubject = PassthroughSubject<Error, Never>()
    @Published private(set) var headlines: [HeadlineModel] = []
    
    // MARK: Lifecycle
    init(remoteDataSource: TopHeadlinesRemoteDataSource = TopHeadlinesRemoteDataSource()) {
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
                self?.headlines = topHeadlines.articles
                    .map { article in
                        HeadlineModel(
                            title: article.title,
                            publishedAt: article.publishedAt,
                            author: article.author,
                            urlToImage: article.urlToImage,
                            url: article.url
                        )
                    }
            }
    }
}
