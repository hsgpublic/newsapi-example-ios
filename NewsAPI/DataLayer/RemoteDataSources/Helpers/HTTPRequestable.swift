//
//  HTTPRequestable.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Foundation
import Combine

protocol HTTPRequestable {
    func request<T: Decodable>(endpoint: Endpointable, type: T.Type) -> AnyPublisher<T, Error>
}
