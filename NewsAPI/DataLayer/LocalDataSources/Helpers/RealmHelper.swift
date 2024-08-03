//
//  RealmHelper.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation
import RealmSwift

final actor RealmHelper {
    // MARK: Properties
    private var realm: Realm?
    
    // MARK: Lifecycle
    init() {
        let configuration = Realm.Configuration(
            schemaVersion: DatabaseConfig.schemaVersion
        )
        Task {
            await initRealm(configuration: configuration)
        }
    }
    
    init(configuration: Realm.Configuration) {
        Task {
            await initRealm(configuration: configuration)
        }
    }
    
    private func initRealm(configuration: Realm.Configuration) async {
        do {
            realm = try await Realm(configuration: configuration, actor: self)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - DatabaseAccessible
extension RealmHelper: DatabaseAccessible {
    func read<T>(entityType: T.Type, query: NSPredicate) async throws -> [T] { guard let realm = self.realm else {
            throw DatabaseError.notInitialized
        }
        guard let objectType = entityType as? Object.Type else {
            throw DatabaseError.entityTypeMismatch(requiredType: Object.self)
        }
        
        return realm.objects(objectType)
            .filter(query)
            .compactMap { $0 as? T }
    }
    
    func upsert<T>(entities: [T]) async throws {
        guard let realm = self.realm else {
            throw DatabaseError.notInitialized
        }
        guard let objects = entities as? [Object] else {
            throw DatabaseError.entityTypeMismatch(requiredType: [Object].self)
        }
        
        try realm.write {
            realm.add(objects, update: .modified)
        }
    }
    
    func delete<T>(entityType: T.Type, query: NSPredicate) async throws {
        guard let realm = self.realm else {
            throw DatabaseError.notInitialized
        }
        guard let objectType = entityType as? Object.Type else {
            throw DatabaseError.entityTypeMismatch(requiredType: Object.self)
        }
        
        try realm.write {
            let objects = realm.objects(objectType)
                .filter(query)
            realm.delete(objects)
        }
    }
}
