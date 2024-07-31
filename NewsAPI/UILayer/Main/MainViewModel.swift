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
    private let repository: TopHeadlinesRepository
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Observables
    var networkErrorPublisher: AnyPublisher<Error, Never> {
        repository.networkErrorSubject
            .eraseToAnyPublisher()
    }
    @Published private(set) var headlineCellDatas: [HeadlineCellData] = []
    
    // MARK: Lifecycle
    init(repository: TopHeadlinesRepository = TopHeadlinesRepository()) {
        self.repository = repository
        bindRepository()
    }
}

// MARK: - Bind
extension MainViewModel {
    func bindRepository() {
        repository.$headlines
            .map { headlines in
                headlines.map { headline in
                    HeadlineCellData(
                        title: headline.title,
                        publishedAt: headline.publishedAt,
                        author: headline.author,
                        urlToImage: headline.urlToImage
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
}
