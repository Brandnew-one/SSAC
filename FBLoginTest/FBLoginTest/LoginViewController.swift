//
//  LoginViewController.swift
//  FBLoginTest
//
//  Created by 신상원 on 2022/01/17.
//

import SnapKit
import FirebaseAuth

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    var verifyID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "휴대폰번호로 로그인 하기!"
        view.backgroundColor = .white
        
        setupView()
        setupConstraints()
        
        loginView.phoneNumberSendButton.addTarget(self, action: #selector(numberButtonClicked), for: .touchUpInside)
        loginView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        Auth.auth().languageCode = "kr";
        
    }
    
    @objc func numberButtonClicked() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(loginView.phoneNumberTextField.text ?? "", uiDelegate: nil) { verificationID, error in
              if error == nil {
                  self.verifyID = verificationID
              } else {
                  print("error: ", error.debugDescription)
              }
          }
    }
    
    @objc func nextButtonClicked() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID ?? "", verificationCode: loginView.cerNumberTextField.text ?? "")
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil {
                print(success ?? "")
                print("User Signed in!")
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    func setupView() {
        view.addSubview(loginView)
    }
    
    func setupConstraints() {
        loginView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
//    func makePhoneNumber() -> String {
//        var number = loginView.phoneNumberTextField.text ?? ""
//        if number.count != 11 {
//            print("잘못된 형식입니다.")
//            return ""
//        } else {
//            return "+82" + number.
//        }
//        return number
//    }
    
}

