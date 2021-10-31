//
//  WeatherAPIManager.swift
//  OpenWeatherApp
//
//  Created by 신상원 on 2021/10/27.
//

import CoreLocation
import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchWeatherData(lon: CLLocationDegrees, lat: CLLocationDegrees, result: @escaping CompletionHandler) {
        
        let url = EndPoint.weatherURL + "lat=\(lat)&lon=\(lon)&appid=\(APIKey.OPENWEATHER)"
        print(url)
        
        
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
