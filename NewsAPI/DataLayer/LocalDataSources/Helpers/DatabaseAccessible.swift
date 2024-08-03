//
//  DatabaseAccessible.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation

protocol DatabaseAccessible {
    func read<T>(entityType: T.Type, predicateFormat: String) async throws -> [T]
    func upsert<T>(entities: [T]) async throws
    func delete<T>(entityType: T.Type, predicateFormat: String) async throws
}
