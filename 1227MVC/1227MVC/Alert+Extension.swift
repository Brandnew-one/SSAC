//
//  Alert+Extension.swift
//  1227MVC
//
//  Created by 신상원 on 2021/12/27.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            okAction()
        }
        alert.addAction(ok)
        self.present(alert,animated: true) {
        }
    }
    
}
