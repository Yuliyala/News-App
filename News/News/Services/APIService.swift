//
//  APIService.swift
//  News
//
//  Created by Yuliya Lapenak on 11/9/22.
//

import Foundation
import Alamofire

class APIService {
    
    private let host = "newsapi.org"
    private let apiKey = "72b35487be894d9cb994067e0a5c0813"
    
    func loadArticles(topic: String, completion: @escaping (NewsResponse?) -> Void) {
        guard let url = buildURL(endpoint: .everything, parameters: [.q(topic)]) else {
            completion(nil)
            return
        }
      loadNews(url: url, completion: completion)
    }
    
    func loadHeadlines( category: String, completion: @escaping (NewsResponse?) -> Void) {
        guard let url = buildURL(endpoint: .headlines, parameters: [.category(category)]) else {
            completion(nil)
            return
        }
        loadNews(url: url, completion: completion)
    }
    
    private func loadNews(url: URL, completion: @escaping (NewsResponse?) -> Void){
        AF.request(url, method: .get).validate().response { response  in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
                do {
                    let newResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    completion(newResponse)
                } catch {
                    print(error)
                    completion(nil)
                }
            case.failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    private func buildURL(endpoint: NewsEndPoint, parameters : [NewsQueryParameters]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoint.rawValue
        
        let queryParameters: [NewsQueryParameters] = parameters + [.apiKey]
        let queryItems = queryParameters.map {$0.queryItem}
        
        components.queryItems = queryItems
        return components.url
    }
}

enum NewsEndPoint: String {
    case everything = "/v2/everything"
    case headlines = "/v2/top-headlines"
}

enum NewsQueryParameters {
    case apiKey
    case q(String)
    case category(String)
    
    var queryItem: URLQueryItem {
        switch self {
        case .apiKey:
            return URLQueryItem(name: "apiKey", value: "72b35487be894d9cb994067e0a5c0813")
        case .q(let string):
            return URLQueryItem(name: "q", value: string)
        case .category(let string):
            return URLQueryItem(name: "category", value: string)
        }
    }
}
