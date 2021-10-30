//
//  TdmbCreditManager.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class TdmbCreditManager {
    
    static let shared = TdmbCreditManager()
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchWeatherData(movieID: String, result: @escaping CompletionHandler) {
        
        let url = EndPoint.tdmbCreditURL + movieID + "/credits?" + APIkey.TDMB
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
