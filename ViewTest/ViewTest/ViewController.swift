//
//  ViewController.swift
//  ViewTest
//
//  Created by 신상원 on 2021/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    let nameCardView = NameCardViewCode()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameCardView)
        
        view.backgroundColor = .white
        
        setNameCardView()
    }
    
    func setNameCardView() {
        nameCardView.backgroundColor = .systemCyan
        nameCardView.imageView.image = UIImage(systemName: "star")
        nameCardView.imageLabel.text = "TEST"
        nameCardView.contentLabel.text = "PLZ"
        
        NSLayoutConstraint.activate([
            nameCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            nameCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            nameCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }

}

