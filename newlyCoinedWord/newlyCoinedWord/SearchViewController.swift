//
//  SearchViewController.swift
//  newlyCoinedWord
//
//  Created by 신상원 on 2021/10/04.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    let newWord: Array<String> = ["자강두천", "공능제", "삼귀자", "꾸꾸꾸", "만반잘부", "레제", "스블재", "점메추해"]
    let newWordAnswer: Array<String> = ["자존심 강한 두 천재들의 대결", "공감능력제로", "연애를 시작하기 전 썸 단계", "꾸며도 꾸질꾸질", "만나서 반갑고 잘부탁", "레이저 제모", "스스로 불러온 재앙", "점심메뉴추천 해줘"]
    
    
    func setButton(button: UIButton) -> (Void) {
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 5)
        button.setTitleColor(.black, for: .normal)
        //button.setTitle(newWord[Int.random(in: 0...7)], for: .normal)
    }
    
    func setRandomWord() -> (Void) {
        var randomNumberSet: Array<Int> = [Int.random(in: 0...newWord.count - 1)]
        var randomNumber: Int
        
        while(true) {
            if randomNumberSet.count == 4 {
                break
            }
            randomNumber = Int.random(in: 0...newWord.count - 1)
            var flag:Bool = true
            for i in 0...randomNumberSet.count - 1 {
                if randomNumberSet[i] == randomNumber {
                    flag = false
                    break
                }
            }
            print(randomNumber)
            if flag {
                randomNumberSet.append(randomNumber)
            }
        }
 
        button1.setTitle(newWord[randomNumberSet[0]], for: .normal)
        button2.setTitle(newWord[randomNumberSet[1]], for: .normal)
        button3.setTitle(newWord[randomNumberSet[2]], for: .normal)
        button4.setTitle(newWord[randomNumberSet[3]], for: .normal)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchStackView.layer.borderWidth = 1
        searchStackView.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchButton.setTitle("", for: .normal)
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        
        //4개의 버튼 설정
        setButton(button: button1)
        setButton(button: button2)
        setButton(button: button3)
        setButton(button: button4)
        setRandomWord()
    }
    
    //Search Button Pressed
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        let matchText: String? = searchTextField.text
        var i: Int = 0
        var flag: Bool = true
        for word in newWord {
            if word == matchText {
                resultLabel.text = newWordAnswer[i]
                flag = false
                break
            }
            i += 1
        }
        if flag {
            resultLabel.text = "처음 듣는 단어입니다..."
        }
        setRandomWord()
    }
    
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
