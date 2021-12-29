//
//  APIService.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/21.
//

import Foundation

class APIService {
    
    
    static func requestCast(completion: @escaping (TVShow?) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/trending/tv/week?" + APIKey.tmdbKey)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("ERROR")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("ERROR")
                    return
                }
                
                if let data = data, let tvData = try? JSONDecoder().decode(TVShow.self, from: data) {
                    completion(tvData)
                    return
                }
            }
        }.resume()
    }
    
    //https://api.themoviedb.org/3/search/tv?api_key=169881821286bdcac4cce29506f8782a&language=ko-KR&page=1&query=%EC%8B%A0 -> insomnia 값
    //https://api.themoviedb.org/3/search/tv?api_key=169881821286bdcac4cce29506f8782a&language=ko-KR&page=1&query=%25EC%258B%25A0 -> url 실제값
    static func requestDetail(_ text: String, completion: @escaping (TVSearch?) -> Void) {
        print("text: \(text)")
        let schme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/tv"
        
//        let key = "169881821286bdcac4cce29506f8782a"
        let key = APIKey.tmdbSearchKey
//        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let query = text
        let language = "ko-KR"
        let page = "1"
        
        var component = URLComponents()
        component.scheme = schme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "query", value: query)
        ]
        print(component.url!)
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("E ERROR")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("R ERROR")
                    return
                }
                
                if let data = data, let tvData = try? JSONDecoder().decode(TVSearch.self, from: data) {
//                    print(tvData.results.first)
//                    print(tvData.page)
//                    print(tvData.totalPages)
                    completion(tvData)
                    return
                }
                else {
                    print("Decode ERROR")
                }
            }
        }.resume()
    }
    
}
