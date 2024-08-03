//
//  TopHeadlinesLocalDataSource.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Combine
import Foundation

final class TopHeadlinesLocalDataSource: TopHeadlinesLocalDataSourceable {
    // MARK: Properties
    private var databaseAccessor: DatabaseAccessible?
    
    // MARK: Lifecycle
    init() {
        Task {
            self.databaseAccessor = await RealmHelper()
        }
    }
    
    init(databaseAccessor: DatabaseAccessible) {
        self.databaseAccessor = databaseAccessor
    }
}

// MARK: - Functions
extension TopHeadlinesLocalDataSource {
    func readHeadlines() -> AnyPublisher<[HeadlineEntity], Error> {
        return Future<[HeadlineEntity], Error> { promise in
            Task { @DatabaseActor [weak self] in
                do {
                    let realmEntities = try await self?.databaseAccessor?.read(
                        entityType: HeadlineRealmObject.self,
                        predicateFormat: ""
                    ) ?? []
                    let entities = realmEntities.map { $0.toHeadlineEntity() }
                    promise(.success(entities))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func upsertHeadlines(entities: [HeadlineEntity]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            Task { @DatabaseActor [weak self] in
                do {
                    let realmEntities = entities.map { $0.toRealmEntity() }
                    try await self?.databaseAccessor?.upsert(entities: realmEntities)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteHeadlines() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            Task { @DatabaseActor [weak self] in
                do {
                    try await self?.databaseAccessor?.delete(
                        entityType: HeadlineRealmObject.self,
                        predicateFormat: ""
                    )
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
