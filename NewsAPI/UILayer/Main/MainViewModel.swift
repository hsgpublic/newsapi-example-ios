//
//  MainViewModel.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Foundation

final class MainViewModel {
    // MARK: Properties
    private let topHeadlinesRepository: TopHeadlinesRepository
    
    // MARK: Lifecycle
    init(topHeadlinesRepository: TopHeadlinesRepository = TopHeadlinesRepository()) {
        self.topHeadlinesRepository = topHeadlinesRepository
    }
}
