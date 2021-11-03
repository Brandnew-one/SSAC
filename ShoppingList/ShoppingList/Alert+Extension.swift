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
    
}
