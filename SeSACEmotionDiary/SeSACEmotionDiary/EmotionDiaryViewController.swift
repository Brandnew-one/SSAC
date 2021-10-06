//
//  EmotionDiaryViewController.swift
//  SeSACEmotionDiary
//
//  Created by 신상원 on 2021/10/06.
//

import UIKit

class EmotionDiaryViewController: UIViewController {

    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    @IBOutlet var labelThree: UILabel!
    
    @IBOutlet var labelFour: UILabel!
    @IBOutlet var labelFive: UILabel!
    @IBOutlet var labelSix: UILabel!
    
    @IBOutlet var labelSeven: UILabel!
    @IBOutlet var labelEight: UILabel!
    @IBOutlet var labelNine: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOne.textAlignment = .center
        labelTwo.textAlignment = .center
        labelThree.textAlignment = .center
        labelFour.textAlignment = .center
        labelFive.textAlignment = .center
        labelSix.textAlignment = .center
        labelSeven.textAlignment = .center
        labelEight.textAlignment = .center
        labelNine.textAlignment = .center
        
        UserDefaults.standard.set(1, forKey: "One")
        UserDefaults.standard.set(1, forKey: "Two")
        UserDefaults.standard.set(1, forKey: "Three")
        UserDefaults.standard.set(1, forKey: "Four")
        UserDefaults.standard.set(1, forKey: "Five")
        UserDefaults.standard.set(1, forKey: "Six")
        UserDefaults.standard.set(1, forKey: "Seven")
        UserDefaults.standard.set(1, forKey: "Eight")
        UserDefaults.standard.set(1, forKey: "Nine")

    }
    
    
    @IBAction func buttonClickedOne(_ sender: UIButton) {
        
        //UserDefaults.standard.set(1, forKey: "One")
        let number = UserDefaults.standard.integer(forKey: "One")
        UserDefaults.standard.set(number + 1, forKey: "One")
        print(number)
        labelOne.text = "행복해 \(number)"
        
    }
    
    @IBAction func buttonClickedTwo(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Two")
        UserDefaults.standard.set(number + 1, forKey: "Two")
        print(number)
        labelTwo.text = "사랑해 \(number)"
    }
    
    
    @IBAction func buttonClickedThree(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Three")
        UserDefaults.standard.set(number + 1, forKey: "Three")
        print(number)
        labelThree.text = "좋아해 \(number)"
    }
    
    @IBAction func buttonClickedFour(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Four")
        UserDefaults.standard.set(number + 1, forKey: "Four")
        print(number)
        labelFour.text = "황당해 \(number)"
    }
    
    @IBAction func buttonClickedFive(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Five")
        UserDefaults.standard.set(number + 1, forKey: "Five")
        print(number)
        labelFive.text = "속상해 \(number)"
    }
    
    @IBAction func buttonClikcedSix(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Six")
        UserDefaults.standard.set(number + 1, forKey: "Six")
        print(number)
        labelSix.text = "우울해 \(number)"
    }
    
    
    @IBAction func buttonClickedSeven(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Seven")
        UserDefaults.standard.set(number + 1, forKey: "Seven")
        print(number)
        labelSeven.text = "심심해 \(number)"
    }
    
    @IBAction func buttonClickedEight(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Eight")
        UserDefaults.standard.set(number + 1, forKey: "Eight")
        print(number)
        labelEight.text = "잠온다 \(number)"
    }
    
    
    @IBAction func buttonClickedNine(_ sender: UIButton) {
        let number = UserDefaults.standard.integer(forKey: "Nine")
        UserDefaults.standard.set(number + 1, forKey: "Nine")
        print(number)
        labelNine.text = "울고싶다 \(number)"
    }
    

}
