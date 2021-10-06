//
//  SecondTabDetailViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by jack on 2021/10/06.
//

import UIKit
import TextFieldEffects

class SecondTabDetailViewController: UIViewController {

    @IBOutlet var mottoTextField: HoshiTextField!
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self, #function)
        
        //값 가져오기
        let userMotto = UserDefaults.standard.string(forKey: "userMotto")
        print(userMotto)
        mottoTextField.text = userMotto
        
        let number = UserDefaults.standard.integer(forKey: "number")
        numberLabel.text = "\(number)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self, #function)
    }
    
    @IBAction func saveButtonClikced(_ sender: UIButton) {
        
        let userText = mottoTextField.text ?? "work hard"
        
        //값 저장
        UserDefaults.standard.set(userText, forKey: "userMotto")
        
    }
    
    
    @IBAction func checkButtonCliked(_ sender: UIButton) {
        
        //let number = Int.random(in: 1...100)
        //UserDefaults.standard.set(number, forKey: "number")
        
        let number = UserDefaults.standard.integer(forKey: "number")
        UserDefaults.standard.set(number + 1, forKey: "number")
        
    }
    
    
}
