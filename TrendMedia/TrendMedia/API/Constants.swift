//
//  Constants.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import Foundation
import Alamofire

struct APIkey {
    
    static let TDMB = "api_key=169881821286bdcac4cce29506f8782a"
    static let NAVER: HTTPHeaders = [
        "X-Naver-Client-Id" : "WDYICMiupgjQDxrvr0uM",
        "X-Naver-Client-Secret" : "e4tQODwl8B"
    ]
    
}

struct EndPoint {
    
    //https://api.themoviedb.org/3/movie/580489/credits?api_key=169881821286bdcac4cce29506f8782a&language=en-US
    static let tdmbURL = "https://api.themoviedb.org/3/trending/movie/day?"
    static let tdmbCreditURL = "https://api.themoviedb.org/3/movie/"
    static let naverURL = "https://openapi.naver.com/v1/search/movie.json?"
}
