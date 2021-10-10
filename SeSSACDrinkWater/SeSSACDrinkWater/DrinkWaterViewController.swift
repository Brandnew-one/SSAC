//
//  DrinkWaterViewController.swift
//  SeSSACDrinkWater
//
//  Created by 신상원 on 2021/10/08.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet var topNavigation: UINavigationItem!
    @IBOutlet var backgroundView: UIView! //for background color
    
    @IBOutlet var leftTopLabel: UILabel!
    @IBOutlet var leftTopLabel2: UILabel!
    @IBOutlet var leftTopLabel3: UILabel!
    @IBOutlet var leftTopLabel4: UILabel!
    
    @IBOutlet var centerImage: UIImageView!
    @IBOutlet var centerTextField: UITextField!
    @IBOutlet var centerRightLabel: UILabel! // just for 'ml'
    
    
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var bottomButton: UIButton!
    
    // #imageLiter(
    let imageSet = [#imageLiteral(resourceName: "1-1"), #imageLiteral(resourceName: "1-2"), #imageLiteral(resourceName: "1-4"), #imageLiteral(resourceName: "1-3"), #imageLiteral(resourceName: "1-5"), #imageLiteral(resourceName: "1-6"), #imageLiteral(resourceName: "1-7"), #imageLiteral(resourceName: "1-8"), #imageLiteral(resourceName: "1-9")]
    
    var goalWater: Int = 0 //목표 퍼센트(이미지 바꿔주기 위해서)
    var totalWater: Int = 0 //오늘 얼마나 마셨나 표시
    //var drinkUnit: Int = 0 // 물을 마신 단위
    var dayWater: Double = 0 //하루에 마셔야 하는 총 물의 양
    
    var userName: String = UserDefaults.standard.string(forKey: "userName") ?? "홍길동"
    var userHeight: Double = UserDefaults.standard.double(forKey: "userHeight") //optional 
    var userWeight: Double = UserDefaults.standard.double(forKey: "userWeight")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.backgroundColor = .systemGreen // 사용자 지정색으로 변경해볼 것
        
        leftTopLabel.textColor = .white
        leftTopLabel.numberOfLines = 1
        leftTopLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        leftTopLabel.text = "잘하셨어요!"
        
        leftTopLabel2.textColor = .white
        leftTopLabel2.numberOfLines = 1
        leftTopLabel2.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        leftTopLabel2.text = "오늘 마신 양은"
        
        leftTopLabel3.textColor = .white
        leftTopLabel3.numberOfLines = 1
        leftTopLabel3.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        leftTopLabel3.text = "\(totalWater)ml"
        
        leftTopLabel4.textColor = .white
        leftTopLabel4.numberOfLines = 1
        leftTopLabel4.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        leftTopLabel4.text = "목표의 \(goalWater)%"
        
        centerTextField.keyboardType = .numberPad
        centerTextField.backgroundColor = .systemGreen
        centerTextField.textColor = .white
        centerTextField.text = "100"
        centerTextField.textAlignment = .center
        centerTextField.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        centerTextField.layer.borderColor = UIColor.systemGreen.cgColor
        centerTextField.layer.borderWidth = 1 //width = 0 으로 설정하면 왜 테두리가 보일까?
        
        centerRightLabel.textColor = .white
        centerRightLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        centerRightLabel.text = "ml"
        
        
        bottomLabel.textColor = .white
        bottomLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .bold)
        bottomLabel.textAlignment = .center
        dayWater = calDayWater(userHeight, userWeight)
        bottomLabel.text = "\(userName)님의 하루 물 권장 섭취량은 \(dayWater)L 입니다."
        
        bottomButton.setTitle("물 마시기", for: .normal)
        bottomButton.setTitleColor(.black, for: .normal)
        
        
        //navigation item -> baritem color 설정
        topNavigation.leftBarButtonItem?.tintColor = .white
        topNavigation.rightBarButtonItem?.tintColor = .white
        topNavigation.title = "물 마시기"
        navigationController?.navigationBar.tintColor = .white // 여기서 설정해줘야 두번째 view 뒤로가기 바뀜
        //topNavigation.color = .black
        
    }
    
    //Profile View 에서 변경사항이 있다면 반영하기 위해서
    override func viewWillAppear(_ animated: Bool) {
        
        userName = UserDefaults.standard.string(forKey: "userName") ?? "홍길동"
        userHeight = UserDefaults.standard.double(forKey: "userHeight")
        userWeight = UserDefaults.standard.double(forKey: "userWeight")
        
        dayWater = calDayWater(userHeight, userWeight)
        bottomLabel.text = "\(userName)님의 하루 물 권장 섭취량은 \(dayWater)L 입니다."
        
    }
    
    //center Text Field -> return 으로 탈출
    @IBAction func waterButtonClicked(_ sender: UITextField) {
        view.endEditing(true)
        
    }
    
    // 물 마시기 버튼을 눌렀을 때
    @IBAction func drinkButtonClicked(_ sender: UIButton) {
        let myString = centerTextField.text ?? "0"
        let waterUnit = Int(myString) ?? 0 //string to int
        totalWater += waterUnit
        print(" 물 단위 : \(waterUnit)")
        print(" 총 마신양 : \(totalWater)")
        
        //totalWater += drinkUnit
        calDayPercent()
        leftTopLabel3.text = "\(totalWater)ml"
        leftTopLabel4.text = "목표의 \(goalWater)%"
        
    }
    
    
    //마신 물 reset
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        totalWater = 0
        calDayPercent() // label 변경 및 image 설정
        leftTopLabel3.text = "\(totalWater)ml"
        leftTopLabel4.text = "목표의 \(goalWater)%"
    }
    
    
    //하루 권장 물 섭취량 계산
    func calDayWater(_ height: Double, _ weight: Double) -> (Double) {
        return (height + weight) / 100
    }
    
    // 목표에 얼마나 도달했는가? + image 변경
    func calDayPercent() -> () {
        dayWater = calDayWater(userHeight, userWeight)
        let dayWaterInt = Int(dayWater * 1000)
        if dayWaterInt == 0 {return} //division Zero 방지
        goalWater = (totalWater * 100) / dayWaterInt
        
        if goalWater < 20 {
            centerImage.image = imageSet[0]
        }
        else if goalWater >= 20 && goalWater < 30 {
            centerImage.image = imageSet[1]
        }
        else if goalWater >= 30 && goalWater < 40 {
            centerImage.image = imageSet[2]
        }
        else if goalWater >= 40 && goalWater < 50 {
            centerImage.image = imageSet[3]
        }
        else if goalWater >= 50 && goalWater < 60 {
            centerImage.image = imageSet[4]
        }
        else if goalWater >= 60 && goalWater < 70 {
            centerImage.image = imageSet[5]
        }
        else if goalWater >= 70 && goalWater < 80 {
            centerImage.image = imageSet[6]
        }
        else if goalWater >= 80 && goalWater < 90 {
            centerImage.image = imageSet[7]
        }
        else {
            centerImage.image = imageSet[8]
        }
        
    }
    
    
    //tap 을 통해 키보드 탈출
    @IBAction func tabGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    

    
}
