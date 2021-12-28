//
//  SignInView.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func settupConstraints()
}

//회원가입 화면 구성
class SignInView: UIView, ViewRepresentable {
    
    let usernameTextField = UITextField()
    let usermailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        settupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [usernameTextField, usermailTextField, passwordTextField, signInButton].forEach { make in
            self.addSubview(make)
        }
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "ID"
        
        usermailTextField.backgroundColor = .white
        usermailTextField.placeholder = "Email"
        
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "PassWord"
        
        signInButton.backgroundColor = .systemCyan
        signInButton.setTitle("회원가입", for: .normal)
    }
    
    func settupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(50)
        }
        usermailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(30)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usermailTextField.snp.bottom).offset(30)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(50)
        }
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
    
}

