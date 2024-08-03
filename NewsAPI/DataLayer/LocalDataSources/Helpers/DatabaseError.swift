//
//  DatabaseAccessError.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

import Foundation

enum DatabaseError: Error {
    case notInitialized
    case entityTypeMismatch(requiredType: Any.Type)
}
