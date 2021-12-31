//
//  ScrollViewController.swift
//  ScrollViewPractice
//
//  Created by 신상원 on 2021/12/31.
//

import UIKit

class ScrollViewController: UIViewController {
    
    var numberOfLines: Bool = false
    
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func lineButtonClicked(_ sender: UIButton) {
        if numberOfLines {
            textView.numberOfLines = 4
            numberOfLines = false
        } else {
            textView.numberOfLines = 0
            numberOfLines = true
        }
    }
    
}
