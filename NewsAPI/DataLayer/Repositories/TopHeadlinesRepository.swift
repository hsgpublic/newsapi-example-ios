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
    private let localDataSource: TopHeadlinesLocalDataSourceable
    private let remoteDataSource: TopHeadlinesRemoteDataSourceable
    private var cancellables = Set<AnyCancellable>()
    private var topHeadlinesCancellable: AnyCancellable?
    
    // MARK: Observables
    let networkErrorSubject = PassthroughSubject<Error, Never>()
    var headlinesPublisher: AnyPublisher<[HeadlineModel], Never> {
        headlinesSubject.eraseToAnyPublisher()
    }
    private let headlinesSubject = CurrentValueSubject<[HeadlineModel], Never>([])
    
    // MARK: Lifecycle
    init(
        localDataSource: TopHeadlinesLocalDataSourceable = TopHeadlinesLocalDataSource(),
        remoteDataSource: TopHeadlinesRemoteDataSourceable = TopHeadlinesRemoteDataSource()
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: Functions
extension TopHeadlinesRepository {
    func fetchTopHeadlines(country: String) {
        fetchLocalHeadlines(country: country)
        fetchRemoteHeadlines(country: country)
    }
    
    func fetchLocalHeadlines(country: String) {
        var cancellable: AnyCancellable?
        cancellable = localDataSource.readHeadlines()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
                if let cancellable {
                    self?.cancellables.remove(cancellable)
                }
            } receiveValue: { [weak self] entities in
                let models = entities.map { $0.toHeadlineModel() }
                guard models.isEmpty == false else {
                    return
                }
                
                self?.headlinesSubject.send(models)
            }
        if let cancellable {
            cancellables.insert(cancellable)
        }
    }
    
    func fetchRemoteHeadlines(country: String) {
        var cancellable: AnyCancellable?
        cancellable = remoteDataSource.getTopHeadlines(country: country)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.networkErrorSubject.send(error)
                case .finished:
                    break
                }
                if let cancellable {
                    self?.cancellables.remove(cancellable)
                }
            } receiveValue: { [weak self] topHeadlines in
                self?.saveRemoteHeadlines(country: country, topHeadlines: topHeadlines)
            }
        if let cancellable {
            cancellables.insert(cancellable)
        }
    }
    
    func saveRemoteHeadlines(country: String, topHeadlines: TopHeadlinesResponseModel) {
        let entities = topHeadlines.articles
            .map { article in
                article.toHeadlineEntity()
            }
        var cancellable: AnyCancellable?
        cancellable = localDataSource.upsertHeadlines(entities: entities)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    self?.fetchLocalHeadlines(country: country)
                    break
                }
                if let cancellable {
                    self?.cancellables.remove(cancellable)
                }
            } receiveValue: {
                
            }
        if let cancellable {
            cancellables.insert(cancellable)
        }
    }
    
    func markVisited(index: Int) {
        guard headlinesSubject.value.indices.contains(index) else {
            return
        }
        
        headlinesSubject.value[index].articleVisited = true
        let headline = headlinesSubject.value[index]
        let entity = headline.toHeadlineEntity()
        var cancellable: AnyCancellable?
        cancellable = localDataSource.upsertHeadlines(entities: [entity])
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
                if let cancellable {
                    self?.cancellables.remove(cancellable)
                }
            } receiveValue: {
                
            }
        if let cancellable {
            cancellables.insert(cancellable)
        }
    }
}
