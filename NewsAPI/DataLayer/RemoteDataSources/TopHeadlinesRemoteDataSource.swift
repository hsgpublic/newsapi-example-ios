//
//  TopHeadlinesRemoteDataSource.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation
import Combine

final class TopHeadlinesRemoteDataSource {
    private let httpRequester: HTTPRequestable
    
    init(httpRequester: HTTPRequestable = AlamofireHelper.shared) {
        self.httpRequester = httpRequester
    }
    
    func getTopHeadlines(country: String) -> AnyPublisher<TopHeadlinesResponseModel, Error> {
        return httpRequester.request(
            endpoint: TopHeadlinesEndpoint(country: country),
            type: TopHeadlinesResponseModel.self
        )
    }
}
