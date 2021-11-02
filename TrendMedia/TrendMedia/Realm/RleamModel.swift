//
//  RleamModel.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/11/02.
//

import Foundation
import RealmSwift

class UserBoxOffice: Object {
    
    @Persisted var yesterdayDate: String // 날짜
    @Persisted var movieRank: String // 순위
    @Persisted var movieTitle: String // 제목
    @Persisted var movieDate: String // 날짜
    
    //PK(필수) : Int, String, UUID, ObjectID 네 가지 사용가능 (ObjectID 는 자동으로)
    @Persisted(primaryKey: true) var _id: ObjectId
    
    //클래스니까 생성자 구현해야 한다!
    convenience init(yesterdayDate: String, movieRank: String, movieTitle: String, movieDate: String) {
        self.init()
        self.yesterdayDate = yesterdayDate
        self.movieRank = movieRank
        self.movieTitle = movieTitle
        self.movieDate = movieDate
    }
}

