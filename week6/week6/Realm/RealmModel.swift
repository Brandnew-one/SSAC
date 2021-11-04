//
//  RealmModel.swift
//  week6
//
//  Created by 신상원 on 2021/11/02.
//

import Foundation
import RealmSwift


// https://docs.mongodb.com/realm/sdk/ios/data-types/supported-property-types/ 침고해서 작성
class UserDiary: Object {
    
    @Persisted var diaryTitle: String //재목(필수)
    @Persisted var diaryContent: String? //내용(옵션)
    @Persisted var diaryDate = Date() //작성 날짜(필수)
    @Persisted var diaryPostDate = Date() //등록일(필수)
    @Persisted var favorite: Bool //즐겨찾기 기능
    
    //PK(필수) : Int, String, UUID, ObjectID 네 가지 사용가능 (ObjectID 는 자동으로)
    @Persisted(primaryKey: true) var _id: ObjectId
    
    //클래스니까 생성자 구현해야 한다!
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, diaryPostDate: Date) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.diaryPostDate = diaryPostDate
        self.favorite = false
    }
}
