//
//  DetailViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/05.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailContentTextField: UITextView!
    

    var imageData: UIImage? = UIImage(systemName: "star")
    var titleData: String = ""
    var dateData: String = ""
    var contentData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClicked))
        
        detailTitleLabel.text = titleData
        detailDateLabel.text = dateData
        detailContentTextField.text = contentData
        detailImageView.image = imageData
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    

}
