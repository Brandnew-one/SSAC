//
//  RandomViewController.swift
//  SSACMOVIE
//
//  Created by 신상원 on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var positionTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var logButton: UIButton!
    @IBOutlet var toggleSwitch: UISwitch!
    
    @IBAction func tapClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleSwitch.isOn = true
        toggleSwitch.onTintColor = .red
        toggleSwitch.thumbTintColor = .white
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        emailTextField.layer.cornerRadius = 5
        emailTextField.clipsToBounds = true
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.clipsToBounds = true
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        nicknameTextField.layer.cornerRadius = 5
        nicknameTextField.clipsToBounds = true
        nicknameTextField.keyboardType = .default
        
        positionTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        positionTextField.layer.cornerRadius = 5
        positionTextField.clipsToBounds = true
        
        codeTextField.attributedPlaceholder = NSAttributedString(string: "추천코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        codeTextField.layer.cornerRadius = 5
        codeTextField.clipsToBounds = true
        codeTextField.keyboardType = .phonePad
        
        logButton.setTitleColor(UIColor.white, for: .normal)
        logButton.layer.cornerRadius = 5
        logButton.clipsToBounds = true
        
        //self.view.endEditing(true)
        
    }
    
    
    @IBAction func switchTapped(_ sender: Any) {
        //스위치가 모두 켜진 경우
        if toggleSwitch.isOn {
            nicknameTextField.isHidden = false
            positionTextField.isHidden = false
            codeTextField.isHidden = false
        }
        
        else {
            nicknameTextField.isHidden = true
            positionTextField.isHidden = true
            codeTextField.isHidden = true
        }
    }
    
    
    @IBAction func logTapped(_ sender: UIButton) {
        if emailTextField.text == nil {
            print("아이디를 다시 입력하세요")
        }
        else {
            print("ID: \(emailTextField.text!)")
        }
        print("PASSWORD: \(passwordTextField.text!)")
        print("NICKNAME: \(nicknameTextField.text!)")
        print("LOCATION: \(positionTextField.text!)")
        print("CODE: \(codeTextField.text!)")
    }
    
    
}
