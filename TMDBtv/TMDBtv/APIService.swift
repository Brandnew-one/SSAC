//
//  APIService.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/21.
//

import Foundation

class APIService {
    
    let sourceURL = URL(string: "https://api.themoviedb.org/3/trending/tv/week?" + APIKey.tmdbKey)!
    
    func requestCast(completion: @escaping (TVShow?) -> Void) {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
            //error 가 nil 값이라는 것은 오류가 발생하지 않음을 의미
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
            
        }.resume()
    }
}
