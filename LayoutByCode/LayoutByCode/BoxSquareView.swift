//
//  BoxSquareView.swift
//  LayoutByCode
//
//  Created by 신상원 on 2021/12/14.
//

import UIKit

class BoxSquareView: UIView {
    
    let button = UIButton()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override init")
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        print("required init")
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        
        //addSubView 를 해주고 나서 설정해줘야 한다 (frame 방식은 상관없는건가?)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        
        //프레임으로 레이아웃 잡아줄 때는 무조건 써줘야한다!!
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black

        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18)
        ])

        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        
//        titleLabel.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 130, height: 40)
//        contentLabel.frame = CGRect(x: 10, y: 60, width: UIScreen.main.bounds.width - 130, height: 40)

    }
    
}
