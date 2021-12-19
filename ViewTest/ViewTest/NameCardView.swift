//
//  NameCardView.swift
//  ViewTest
//
//  Created by 신상원 on 2021/12/19.
//

import UIKit

class NameCardView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        loadUI()
    }
    
    func loadView() {
        let view = UINib(nibName: "NameCardView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)
        view.frame = bounds // 이거 안쓰면 우째되나?
        view.backgroundColor = .systemCyan
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
    }
    
    func loadUI() {
        imageView.image = UIImage(systemName: "star.fill")
        imageLabel.textAlignment = .center
        imageLabel.text = "TEST"
        contentLabel.text = "PLZ"
    }
    
}
