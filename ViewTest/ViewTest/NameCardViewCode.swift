//
//  NameCardViewCode.swift
//  ViewTest
//
//  Created by 신상원 on 2021/12/19.
//

import UIKit

class NameCardViewCode: UIView {
    
    let imageView = UIImageView()
    let imageLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        self.addSubview(imageView)
        self.addSubview(imageLabel)
        self.addSubview(contentLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageLabel.textAlignment = .center
        imageLabel.font = .boldSystemFont(ofSize: 20)
        contentLabel.font = .systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            imageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            imageLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 18)
        ])
        
    }
 
}

