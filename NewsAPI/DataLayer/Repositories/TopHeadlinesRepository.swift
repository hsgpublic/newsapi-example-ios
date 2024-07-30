//
//  TopHeadlinesRepository.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation
import Combine

final class TopHeadlinesRepository {
    private let remoteDataSource: TopHeadlinesRemoteDataSource
    
    init(remoteDataSource: TopHeadlinesRemoteDataSource = TopHeadlinesRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
}
