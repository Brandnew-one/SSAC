//
//  LEDBoardViewController.swift
//  LEDBoard
//
//  Created by 신상원 on 2021/10/01.
//

import UIKit

class LEDBoardViewController: UIViewController {
    
    
    @IBOutlet var topViewSet: UIView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //최상단 버튼이 모여있는 view 설정
        topViewSet.clipsToBounds = true
        topViewSet.layer.cornerRadius = 10
        topViewSet.layer.borderWidth = 0
        
        //텍스트 필드의 테두리 경계선 없어지게 하기 위해서
        userTextField.borderStyle = .none
        
        //보내기 버튼 초기 설정
        sendButton.clipsToBounds = true
        sendButton.layer.cornerRadius = 10
        sendButton.layer.borderWidth = 2.0
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.setTitle("보내기", for: .normal)
        sendButton.setTitleColor(.black, for: .normal)
        
        //Aa 버튼 초기 설정
        colorButton.clipsToBounds = true
        colorButton.layer.cornerRadius = 10
        colorButton.layer.borderWidth = 2.0
        colorButton.layer.borderColor = UIColor.black.cgColor
        colorButton.setTitle("Aa", for: .normal)
        colorButton.setTitleColor(.red, for: .normal)
        
        resultLabel.textColor = .white
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.numberOfLines = 1
        resultLabel.textAlignment  = .center
        resultLabel.minimumScaleFactor = 0.1
        

    }
    
    //보내기 버튼을 통해서 label에 사용자가 입력한 text 설정
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        resultLabel.text = userTextField.text
    }
    
    //enter 버튼을 통해 키보드 닫는거 구현
    @IBAction func textFieldClicked(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    //tap 을 통해서 상단 hide & show
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        if topViewSet.isHidden {
            topViewSet.isHidden = false
            //print("t -> f")
        }
        else {
            topViewSet.isHidden = true
            //print("f -> t")
        }
    }
    
    //Aa 버튼 눌렀을 때,색깔 바뀌는 거  구현
    @IBAction func colorButtonClicked(_ sender: UIButton) {
        
        //random RGB 설정
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        //RGB 조합해서 만들기
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        // 랜덤색상 설정
        resultLabel.textColor = randomColor
    }
    
    
    
}
