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

//Q1) 여기서도 기본키는 여전히 필요할까? 그럼 Realm 데이터 2개를 동시에 사용하겠다는 의미인가?
class UserTask: Object {
    
    @Persisted var movieRank: String // 순위
    @Persisted var movieTitle: String // 제목
    @Persisted var movieDate: String // 날짜
    
    //PK(필수) : Int, String, UUID, ObjectID 네 가지 사용가능 (ObjectID 는 자동으로)
    @Persisted(primaryKey: true) var _id: ObjectId
    
    //클래스니까 생성자 구현해야 한다!
    convenience init(movieRank: String, movieTitle: String, movieDate: String) {
        self.init()
        self.movieRank = movieRank
        self.movieTitle = movieTitle
        self.movieDate = movieDate
    }
}

class UserProject: Object {
    
    @Persisted var yesterdayDate: String
    @Persisted var boxOffice: List<UserTask>
    
    //PK(필수) : Int, String, UUID, ObjectID 네 가지 사용가능 (ObjectID 는 자동으로)
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(yesterdayDate: String, boxOffice: [UserTask]) {
        self.init()
        self.yesterdayDate = yesterdayDate
        self.boxOffice.append(objectsIn: boxOffice)
    }
}
