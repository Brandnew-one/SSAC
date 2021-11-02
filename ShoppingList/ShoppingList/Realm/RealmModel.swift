//
//  RealmModel.swift
//  ShoppingList
//
//  Created by 신상원 on 2021/11/02.
//

import Foundation
import RealmSwift


class UserList: Object {
    
    @Persisted var shoppingCheck: Bool //즐겨찾기 기능
    @Persisted var shoppingTitle: String //재목(필수)
    @Persisted var shoppingFavorite: Bool //즐겨찾기 기능
    
    //PK(필수) : Int, String, UUID, ObjectID 네 가지 사용가능 (ObjectID 는 자동으로)
    @Persisted(primaryKey: true) var _id: ObjectId
    
    //클래스니까 생성자 구현해야 한다!
    convenience init(shoppingCheck: Bool, shoppingTitle: String, shoppingFavorite: Bool) {
        self.init()
        self.shoppingCheck = shoppingCheck
        self.shoppingTitle = shoppingTitle
        self.shoppingFavorite = shoppingFavorite
    }
}

