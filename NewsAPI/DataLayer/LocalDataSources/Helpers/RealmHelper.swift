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
    func read<T: HeadlineEntityable>(entityType: T.Type, query: NSPredicate) async throws -> [T] {
        return []
    }
    
    func upsert<T: HeadlineEntityable>(entities: [T]) async throws {
        
    }
    
    func delete<T: HeadlineEntityable>(entities: [T], query: NSPredicate) async throws {
        
    }
    
    func deleteAll<T: HeadlineEntityable>(entityType: T.Type, query: NSPredicate) async throws {
        
    }
}
