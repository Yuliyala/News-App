//
//  ArticleModel.swift
//  News
//
//  Created by Yuliya Lapenak on 11/9/22.
//

import Foundation


struct NewsResponse: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
    let source: Source
    let author: String?
    let title : String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var fullAuthor: String {
//        var endString = ""
//        if let author = author {
//            endString = ", " + author
//        }
//        return source.name + endString
        source.name + (author != nil ? ", \(author!)" : "")
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = formatter.date(from: self)
        return localDate
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd MMMM yyyy"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
}
