//
//  AlamofireHelper.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/30/24.
//

import Alamofire
import Combine
import Foundation

final class AlamofireHelper: HTTPRequestable {
    static let shared = AlamofireHelper()
    private init() { }
    
    func request<T: Decodable>(endpoint: Endpointable, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            let error = NSError(
                domain: "Bad URL.",
                code: URLError.badURL.rawValue,
                userInfo: ["urlString": endpoint.urlString]
            )
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let headerArray = endpoint.headers.map { (name, value) in
            HTTPHeader(name: name, value: value)
        }
        let headers = HTTPHeaders(headerArray)
        
        return AF.request(
            url,
            method: HTTPMethod(rawValue: endpoint.method.rawValue),
            parameters: endpoint.parameters,
            headers: headers
        )
        .publishDecodable(type: T.self)
        .value()
        .mapError { $0 }
        .eraseToAnyPublisher()
    }
}
