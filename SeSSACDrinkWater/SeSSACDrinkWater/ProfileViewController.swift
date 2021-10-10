//
//  ProfileViewController.swift
//  SeSSACDrinkWater
//
//  Created by 신상원 on 2021/10/09.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var backgroundView2: UIView!
    @IBOutlet var topNavigation2: UINavigationItem!
    @IBOutlet var settingView: UIView! //layout 을 위해 선언된 UIView
    
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var userHeightLabel: UILabel!
    @IBOutlet var userHeightTextField: UITextField!
    
    @IBOutlet var userWeightLabel: UILabel!
    @IBOutlet var userWeightTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView2.backgroundColor = .systemGreen
        settingView.backgroundColor = .systemGreen
        
        userNameLabel.text = "닉네임을 설정해주세요"
        userNameLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        userNameLabel.textColor = .white
        let userName = UserDefaults.standard.string(forKey: "userName")
        
        userNameTextField.text = userName
        userNameTextField.backgroundColor = .systemGreen
        userNameTextField.textColor = .white
        userNameTextField.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        userNameTextField.layer.borderWidth = 1
        
        
        userHeightLabel.text = "키(cm)를 설정해주세요"
        userHeightLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        userHeightLabel.textColor = .white
        let userHeight = UserDefaults.standard.double(forKey: "userHeight")
        
        userHeightTextField.keyboardType = .numberPad
        userHeightTextField.text = "\(userHeight)cm"
        userHeightTextField.backgroundColor = .systemGreen
        userHeightTextField.textColor = .white
        userHeightTextField.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        userHeightTextField.layer.borderColor = UIColor.white.cgColor
        userHeightTextField.layer.borderWidth = 1
        
        
        userWeightLabel.text = "몸무게(kg)를 설정해주세요"
        userWeightLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        userWeightLabel.textColor = .white
        let userWeight = UserDefaults.standard.double(forKey: "userWeight")
        
        userWeightTextField.keyboardType = .numberPad
        userWeightTextField.text = "\(userWeight)kg"
        userWeightTextField.backgroundColor = .systemGreen
        userWeightTextField.textColor = .white
        userWeightTextField.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        userWeightTextField.layer.borderColor = UIColor.white.cgColor
        userWeightTextField.layer.borderWidth = 1
        
        topNavigation2.leftBarButtonItem?.title = "물 마시기"
        topNavigation2.leftBarButtonItem?.tintColor = .white
        topNavigation2.rightBarButtonItem?.title = "저장"
        topNavigation2.rightBarButtonItem?.tintColor = .white
        
    
    }
    
    
    //각 텍스트 필드 return 을 통해서 키보드 내리기 (did End on Exit)
    @IBAction func userNameClicked(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
    @IBAction func userHeightClicked(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
    @IBAction func userWeightClicked(_ sender: UITextField) {
        view.endEditing(true)
    }
   
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        userNameTextField.placeholder = userNameTextField.text
        UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
        
        userHeightTextField.placeholder = userHeightTextField.text
        UserDefaults.standard.set(userHeightTextField.text, forKey: "userHeight")
        
        userWeightTextField.placeholder = userWeightTextField.text
        UserDefaults.standard.set(userWeightTextField.text, forKey: "userWeight")
        
    }
    
    
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    

}
