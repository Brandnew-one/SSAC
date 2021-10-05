//
//  FoodViewController.swift
//  BM
//
//  Created by 신상원 on 2021/10/01.
//

import UIKit

class FoodViewController: UIViewController {

    
    @IBOutlet var userSearchTextField: UITextField!
    @IBOutlet var tagButton1: UIButton!
    @IBOutlet var tagButton2: UIButton!
    @IBOutlet var tagButton3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //buttonOutletName: 매개변수(parameter) -- tagButton1: 전달인자(Argument)
        
        buttonUISetting(tagButton1, buttonTitle: "사탕")
        buttonUISetting(tagButton2, buttonTitle: "초콜릿")
        buttonUISetting(tagButton3, buttonTitle: "츄러스")
    }
    
    // _ : 외부 매개변수 이름 생략 가능 -> 와일드 카드 식별자
    func buttonUISetting(_ btn: UIButton, buttonTitle title: String = "눈이 감긴다..") {
        
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white

    }
    
    //didEndonExit
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        //키보드 내리기
        view.endEditing(true)
    }
    
    
    @IBAction func foodTagButtonCliked(_ sender: UIButton) {
        userSearchTextField.text = sender.currentTitle
    }
    
    
    

}
