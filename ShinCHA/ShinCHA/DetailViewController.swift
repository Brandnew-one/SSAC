//
//  DetailViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/18.
//

import UIKit

class DetailViewController: UIViewController {

    var movieLable: String?
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieLable
    
    }
    
    
    
    

}
