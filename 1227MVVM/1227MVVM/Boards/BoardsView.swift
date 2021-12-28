//
//  BoardsView.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import UIKit
import SnapKit


class BoardsView: UIView, ViewRepresentable {
    
    let text = UILabel()
    let username = UILabel()
    let email = UILabel()
    let createdDate = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        settupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [text, username, email, createdDate].forEach {
            addSubview($0)
        }
        text.backgroundColor = .white
        username.backgroundColor = .white
        email.backgroundColor = .white
        createdDate.backgroundColor = .white
    }
    
    func settupConstraints() {
        text.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        username.snp.makeConstraints { make in
            make.top.equalTo(text.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        email.snp.makeConstraints { make in
            make.top.equalTo(username.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        createdDate.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
