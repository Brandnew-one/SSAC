//
//  BoxOfficeAPIManager.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/11/02.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class BoxOfficeManager {
    
    static let shared = BoxOfficeManager()
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchBoxOfficeData(date: String, result: @escaping CompletionHandler) {

        let url = EndPoint.boxOfficeURL + APIkey.BOXOFFICE + "&targetDt=" + date
        //print(url)
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
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
