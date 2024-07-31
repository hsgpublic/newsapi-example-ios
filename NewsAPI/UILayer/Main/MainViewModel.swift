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
    @Published private(set) var headlines: [HeadlineModel] = []
    
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
            .sink { [weak self] headlines in
                self?.headlines = headlines
            }
            .store(in: &cancellables)
    }
}

// MARK: - Functions
extension MainViewModel {
    func fetchTopHeadlines(country: String) {
        repository.fetchTopHeadlines(country: country)
    }
}
