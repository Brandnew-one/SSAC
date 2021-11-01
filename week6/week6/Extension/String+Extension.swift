//
//  String+Extension.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import Foundation

extension String {
    
    //get 생략가능
    
    var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    //위의 연산 프로퍼티 기능까지 커버할 수 있음(디폴트 파라미터 사용)
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
    
}
