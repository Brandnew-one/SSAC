//
//  Alert+Extension.swift
//  ShoppingList
//
//  Created by 신상원 on 2021/11/03.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showActionSheet(checkAction: @escaping () -> (), titleAction: @escaping () -> (), starAction: @escaping () -> ()) {
        let alert = UIAlertController(title: "정렬기준", message: "기준에 맞게 정렬합니다.", preferredStyle: .actionSheet)
        let check = UIAlertAction(title: "할일 기준 정렬", style: .default) { _ in
            print("Check Sort")
            checkAction()
        }
        let title = UIAlertAction(title: "제목 기준 정렬", style: .default) { _ in
            print("Title Sort")
            titleAction()
        }
        let star = UIAlertAction(title: "즐겨찾기 기준 정렬", style: .default) { _ in
            print("Star Sort")
            starAction()
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(check)
        alert.addAction(title)
        alert.addAction(star)
        alert.addAction(cancle)
        
        self.present(alert, animated: true) {
            print("액션시트가 올라왔습니다")
        }
    }
    
    func showAlert(okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: "휴대폰을 종료", message: "휴대폰을 종료하겠습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            print("백업을 완료하면 앱을 재실행합니다.")
            okAction()
        }
        
        alert.addAction(ok)
        self.present(alert,animated: true) {
            print("얼럿이 떴습니다~!")
        }
    }
}
