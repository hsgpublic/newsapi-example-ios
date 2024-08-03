//
//  TopHeadlinesLocalDataSourceable.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Combine
import Foundation

protocol TopHeadlinesLocalDataSourceable {
    func readHeadlines() -> AnyPublisher<[HeadlineEntity], Error>
    func upsertHeadlines(entities: [HeadlineEntity]) -> AnyPublisher<Void, Error>
    func deleteHeadlines() -> AnyPublisher<Void, Error>
}
