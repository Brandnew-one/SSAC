//
//  TestViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by 신상원 on 2021/10/06.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var labelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCollection[0].setTitle("1", for: .normal)
        buttonCollection[1].setTitle("2", for: .normal)
        buttonCollection[2].setTitle("3", for: .normal)

    }
    
    
    

}
