//
//  TestViewController.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/20.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
        print("현재 최상단 View는 ?")
        print(rootViewController)
    }
    
}
