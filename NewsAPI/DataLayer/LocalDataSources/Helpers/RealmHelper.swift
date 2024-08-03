//
//  RealmHelper.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation
import RealmSwift

@DatabaseActor
final class RealmHelper {
    // MARK: Properties
    private var realm: Realm?
    
    // MARK: Lifecycle
    init() async {
        let configuration = Realm.Configuration(
            schemaVersion: DatabaseConfig.schemaVersion
        )
        await initRealm(configuration: configuration)
    }
    
    init(configuration: Realm.Configuration) async {
        await initRealm(configuration: configuration)
    }
    
    private func initRealm(configuration: Realm.Configuration) async {
        do {
            realm = try await Realm(configuration: configuration, actor: DatabaseActor.shared)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - DatabaseAccessible
extension RealmHelper: DatabaseAccessible {
    func read<T>(entityType: T.Type, predicateFormat: String) async throws -> [T] {
        guard let realm = self.realm else {
            throw DatabaseError.notInitialized
        }
        guard let objectType = entityType as? Object.Type else {
            throw DatabaseError.entityTypeMismatch(requiredType: Object.self)
        }
        
        let objects = realm.objects(objectType)
        let filtered = if predicateFormat.isEmpty {
            objects
        } else {
            objects.filter(predicateFormat)
        }
        return filtered.compactMap { $0 as? T }
    }
    
    func upsert<T>(entities: [T]) async throws {
        guard let realm = self.realm else {
            throw DatabaseError.notInitialized
        }
        guard let objects = entities as? [Object] else {
            throw DatabaseError.entityTypeMismatch(requiredType: [Object].self)
        }
        
        try await realm.asyncWrite {
            realm.add(objects, update: .modified)
        }
    }
    
    func delete<T>(entityType: T.Type, predicateFormat: String) async throws {
        guard let realm = self.realm else {
            throw DatabaseError.notInitialized
        }
        guard let objectType = entityType as? Object.Type else {
            throw DatabaseError.entityTypeMismatch(requiredType: Object.self)
        }
        
        try await realm.asyncWrite {
            let objects = realm.objects(objectType)
            let filtered = if predicateFormat.isEmpty {
                objects
            } else {
                objects.filter(predicateFormat)
            }
            realm.delete(filtered)
        }
    }
}
