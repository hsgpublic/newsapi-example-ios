//
//  TopHeadlinesRemoteDataSourceable.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/2/24.
//

import Foundation
import Combine

protocol TopHeadlinesRemoteDataSourceable {
    func getTopHeadlines(country: String) -> AnyPublisher<TopHeadlinesResponseModel, Error>
}
