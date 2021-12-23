//
//  APIService.swift
//  PUNKBeer
//
//  Created by 신상원 on 2021/12/22.
//

import Foundation

class APIService {
    
    let url = URL(string: (APIKey.endPoint + APIKey.random))!
    
    func requestBeer(completion: @escaping (BeerElement?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
//            print("ERROR:\n", error)
//            print("RESPONSE:\n", response)
//            print("DATA: \n", data)
            
            if let error = error {
                print("ERROR = Nil", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("check STATUS CODE")
                return
            }
            
            if let data = data, let beerData = try? JSONDecoder().decode([BeerElement].self, from: data) {
                completion(beerData.first)
                return
            }
            else {
                print("DECODE FAIL")
            }
        }.resume()
        
    }
}
