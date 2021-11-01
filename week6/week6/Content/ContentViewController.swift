//
//  ContentViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit

class ContentViewController: UIViewController {
    
    
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "일기작성"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))

    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func saveButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

}
