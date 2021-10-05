//
//  RandomViewController.swift
//  BM
//
//  Created by 신상원 on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet var randomLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    
    //view controller life cycle
    //화면이 사용자에게 보이기 직전에 실행되는 기능 : 모서리 둥글게, 그림자 속성
    // 스토리보드에서 구현하기 까다로운 UI를 미리 구현할 때 주로 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ().() 왼쪽 타입이 동일하면 생략할 수 있음
        randomLabel.text = "안녕하세요\n반갑습니다"
        randomLabel.textAlignment = .center
        randomLabel.backgroundColor = .systemRed
        randomLabel.numberOfLines = 2
        randomLabel.font = UIFont.boldSystemFont(ofSize: 20)
        randomLabel.textColor = UIColor.white
        randomLabel.layer.cornerRadius = 10
        randomLabel.clipsToBounds = true
        //button은 기본적으로 check 되어 있어서 둥글게 설정되는 거
        
        checkButton.backgroundColor = UIColor.magenta
        checkButton.setTitle("행운의 숫자를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽑아 뽑아", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    //viewDidLoad는 계속 실행되는 건가?
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        
        let number = Int.random(in: 1...100)
        randomLabel.text = "행운의 숫자는 \(number) 입니다."
    }
    
    
}
