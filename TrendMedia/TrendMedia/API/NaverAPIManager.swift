//
//  naverAPIManager.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/30.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class NaverAPIManager {
    
    static let shared = NaverAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchMovieSearchData(query: String,startPage: Int, result: @escaping CompletionHandler) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.naverURL + "query=\(query)&display=10&start=\(startPage)"
        
        
        AF.request(url, method: .get, headers: APIkey.NAVER).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let code = response.response?.statusCode ?? 500
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
