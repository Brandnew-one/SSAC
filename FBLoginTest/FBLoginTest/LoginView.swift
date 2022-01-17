//
//  LoginView.swift
//  FBLoginTest
//
//  Created by 신상원 on 2022/01/17.
//

import SnapKit
import UIKit

//Rx로 업데이트 시켜보기
class LoginView: UIView {
    
    let phoneNumberTextField = UITextField()
    let phoneNumberSendButton = UIButton()
    let cerNumberTextField = UITextField()
    let nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [phoneNumberTextField, phoneNumberSendButton, cerNumberTextField, nextButton].forEach {
            self.addSubview($0)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
        }
        
        phoneNumberTextField.placeholder = "  휴대폰 번호"
        phoneNumberTextField.layer.borderColor = CGColor.init(red: 0, green: 40, blue: 0, alpha: 1)
        phoneNumberTextField.layer.borderWidth = 1
        
        cerNumberTextField.placeholder = "  인중번호"
        cerNumberTextField.layer.borderColor = CGColor.init(red: 0, green: 40, blue: 0, alpha: 1)
        cerNumberTextField.layer.borderWidth = 1
        
        phoneNumberSendButton.setTitle("Send", for: .normal)
        phoneNumberSendButton.backgroundColor = .systemGray2
        nextButton.setTitle("Done", for: .normal)
        nextButton.backgroundColor = .systemGray2
    }
    
    func setupConstraints() {
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.width.equalTo(250)
            make.height.equalTo(70)
        }
        
        phoneNumberSendButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.top)
            make.leading.equalTo(phoneNumberTextField.snp.trailing).offset(20)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        cerNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.leading.equalTo(phoneNumberTextField.snp.leading)
            make.width.equalTo(250)
            make.height.equalTo(70)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(cerNumberTextField.snp.top)
            make.leading.equalTo(cerNumberTextField.snp.trailing).offset(20)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
    }
    
}
