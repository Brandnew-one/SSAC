//
//  LotteryViewController.swift
//  LotteryApp
//
//  Created by 신상원 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

var lottery: [Int] = []

// <추가적으로 구현해야 하는 것>
// 1 ) 올바르지 않은 데이터들에 대한 얼럿 설정
// 2 ) 텍스트필드를 통해 입력한 데이터에 맞게 pickerview 도 이동하도록 설정
// 3 ) 현재 날짜에 따라 자동으로 회차 최신화

class LotteryViewController: UIViewController {
    
    var todayNumber = 1
        
    @IBOutlet weak var lotteryPickerView: UIPickerView!
    @IBOutlet weak var lotteryTextField: UITextField!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var thirdNumberLabel: UILabel!
    @IBOutlet weak var fourthNumberLabel: UILabel!
    @IBOutlet weak var fifthNumberLabel: UILabel!
    @IBOutlet weak var sixthNumberLabel: UILabel!
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var bonusNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        for i in 1...987 {
            lottery.append(i)
        }
        
        super.viewDidLoad()
        
        //Label 둥글게 만들기 위한 설정 -> 다음부터 Outlet Collectino 이용!
        firstNumberLabel.clipsToBounds = true
        firstNumberLabel.layer.cornerRadius = 20
        secondNumberLabel.clipsToBounds = true
        secondNumberLabel.layer.cornerRadius = 20
        thirdNumberLabel.clipsToBounds = true
        thirdNumberLabel.layer.cornerRadius = 20
        fourthNumberLabel.clipsToBounds = true
        fourthNumberLabel.layer.cornerRadius = 20
        fifthNumberLabel.clipsToBounds = true
        fifthNumberLabel.layer.cornerRadius = 20
        sixthNumberLabel.clipsToBounds = true
        sixthNumberLabel.layer.cornerRadius = 20
        plusLabel.clipsToBounds = true
        plusLabel.layer.cornerRadius = 20
        bonusNumberLabel.clipsToBounds = true
        bonusNumberLabel.layer.cornerRadius = 20
        lotteryTextField.keyboardType = .numberPad
        
        lotteryPickerView.delegate = self
        lotteryPickerView.dataSource = self
    }
    
    
    func getCurrentNumber(index: Int) {
        
        resultLabel.text = "\(index)회 당첨결과"
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(index)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                self.firstNumberLabel.text = "\(json["drwtNo1"].intValue)"
                self.secondNumberLabel.text = "\(json["drwtNo2"].intValue)"
                self.thirdNumberLabel.text = "\(json["drwtNo3"].intValue)"
                self.fourthNumberLabel.text = "\(json["drwtNo4"].intValue)"
                self.fifthNumberLabel.text = "\(json["drwtNo5"].intValue)"
                self.sixthNumberLabel.text = "\(json["drwtNo6"].intValue)"
                self.bonusNumberLabel.text = "\(json["bnusNo"].intValue)"
                self.dayLabel.text = "\(json["drwNoDate"].stringValue) 추첨"
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getTodayNumber() {
        
        let calender = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from: "2002-12-07")
        let today = Date()
        todayNumber = calender.dateComponents([.day], from: startDate!, to: today).day! + 1
        
        print(todayNumber)
    }
    
    
    //만약 숫자패드가 아닐경우를 대비
    @IBAction func lotteryTextFieldTapped(_ sender: UITextField) {
        
        let text = lotteryTextField.text ?? "0"
        let number = Int(text) ?? 0
        print(number)

        return getCurrentNumber(index: number)
        
    }
    
    //숫자 패드를 사용할 경우
    @IBAction func lotteryTextFieldTapped2(_ sender: UITextField) {
        let text = lotteryTextField.text ?? "0"
        let number = Int(text) ?? 0
        print(number)

        return getCurrentNumber(index: number)
    }
    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}



extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottery.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(lottery[row]) 회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //lotteryTextField.text = "\(lottery[row]) 회차"
        //resultLabel.text = "\(lottery[row])회 당첨결과"
        getCurrentNumber(index: lottery[row])
        
    }
    
    
}
