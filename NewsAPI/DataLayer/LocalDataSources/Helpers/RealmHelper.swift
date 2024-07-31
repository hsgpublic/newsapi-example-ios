//
//  RealmHelper.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation
import RealmSwift

final actor RealmHelper: DatabaseAccessible {
    // MARK: Properties
    private var realm: Realm!
    
    // MARK: Lifecycle
    init() async throws {
        let configuration = Realm.Configuration(
            schemaVersion: DatabaseConfig.schemaVersion
        )
        try await initRealm(configuration: configuration)
    }
    
    init(configuration: Realm.Configuration) async throws {
        try await initRealm(configuration: configuration)
    }
    
    private func initRealm(configuration: Realm.Configuration) async throws {
        realm = try await Realm(configuration: configuration, actor: self)
    }
}
