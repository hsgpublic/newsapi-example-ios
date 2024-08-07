//
//  MainViewModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Combine
import Foundation

final class MainViewModel {
    // MARK: Properties
    private let repository: TopHeadlinesRepositoryable
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Observables
    var networkErrorPublisher: AnyPublisher<Error, Never> {
        repository.networkErrorSubject
            .eraseToAnyPublisher()
    }
    @Published private(set) var headlineCellDatas: [HeadlineCellData] = []
    
    // MARK: Lifecycle
    init(repository: TopHeadlinesRepositoryable = TopHeadlinesRepository()) {
        self.repository = repository
        bindRepository()
    }
}

// MARK: - Bind
extension MainViewModel {
    func bindRepository() {
        repository.headlinesPublisher
            .map { headlines in
                headlines.map { headline in
                    let formattedPublishedAt = headline.publishedAt
                        .currentLocaledDateString(fromFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")
                    return HeadlineCellData(
                        title: headline.title,
                        publishedAt: headline.publishedAt,
                        formattedPublishedAt: formattedPublishedAt,
                        author: headline.author,
                        urlToImage: headline.urlToImage,
                        articleURL: headline.url,
                        articleVisited: headline.articleVisited
                    )
                }
            }
            .sink { [weak self] cellDatas in
                self?.headlineCellDatas = cellDatas
            }
            .store(in: &cancellables)
    }
}

// MARK: - Functions
extension MainViewModel {
    func fetchTopHeadlines(country: String) {
        repository.fetchTopHeadlines(country: country)
    }
    
    func headlineCellData(at index: Int) -> HeadlineCellData? {
        guard headlineCellDatas.indices.contains(index) else {
            return nil
        }
        
        return headlineCellDatas[index]
    }
    
    func markVisited(index: Int) {
        repository.markVisited(index: index)
    }
}
