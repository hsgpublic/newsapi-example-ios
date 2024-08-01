//
//  StringExtension.swift
//  NewsAPI
//
//  Created by 구홍석 on 8/1/24.
//

import Foundation

// MARK: - Date format
extension String {
    func currentLocaledDateString(fromFormat: String) -> String {
        let fromFormatter = DateFormatter()
        fromFormatter.timeZone = .gmt
        fromFormatter.dateFormat = fromFormat
        
        guard let date = fromFormatter.date(from: self) else {
            return self
        }
        
        let toFormatter = DateFormatter()
        toFormatter.locale = .current
        toFormatter.timeZone = .current
        toFormatter.dateStyle = .medium
        toFormatter.timeStyle = .short
        return toFormatter.string(from: date)
    }
}
