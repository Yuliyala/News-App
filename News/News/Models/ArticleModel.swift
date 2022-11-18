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
}

struct Source: Codable {
    let id: String?
    let name: String
}

