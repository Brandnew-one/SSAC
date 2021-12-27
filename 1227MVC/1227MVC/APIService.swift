//
//  APIService.swift
//  1227MVC
//
//  Created by 신상원 on 2021/12/27.
//

import Foundation

enum APIError {
    case failed
    case noData
    case errorCode
    case decodeFail
}

class APIService {
    
    static func signin(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/auth/local/register")!
        
        //HTTP Method (POST & Form 설정)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        //shared 를 이용 (기본설정에서 수정할 수 없음) -> CompletionHandler
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
            if let error = error {
                completion(nil, .failed)
                return
            }
            //data 가 nil 이면 오류를 의미하니까 바로 종료
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            // URLResponse 로 캐스팅 되지 않으면 오류
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .failed)
                return
            }
            // 200번대 statusCode 가 아니라면 오류
            if !(200...299).contains(response.statusCode) {
                completion(nil, .errorCode)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .decodeFail)
            }
            
        }.resume()
        
    }
    
}
