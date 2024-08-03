//
//  DatabaseAccessible.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation

protocol DatabaseAccessible {
    func read<T: HeadlineEntityable>(entityType: T.Type, query: NSPredicate) async throws -> [T]
    func upsert<T: HeadlineEntityable>(entities: [T]) async throws
    func delete<T: HeadlineEntityable>(entities: [T], query: NSPredicate) async throws
    func deleteAll<T: HeadlineEntityable>(entityType: T.Type, query: NSPredicate) async throws
}
