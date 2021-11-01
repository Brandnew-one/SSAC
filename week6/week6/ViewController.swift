//
//  ViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var welcomLabel: UILabel!
    @IBOutlet weak var backupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        S-Core Dream
//        =======> S-CoreDream-2ExtraLight
//        =======> S-CoreDream-5Medium
//        =======> S-CoreDream-9Black
        
        for family in UIFont.familyNames {
            print(family)

            for sub in UIFont.fontNames(forFamilyName: family) {
                print("=======> \(sub)")
            }
        }
        
        //일본어 대응하지 않았을 경우 "welcome_text" 그대로 나오는거 확인
        //welcomLabel.text = NSLocalizedString("welcome_text", comment: "")
        //welcomLabel.text = "welcome_text".localized
        welcomLabel.text = LocalizableStrings.welcome_text.localized
        
        //Font 적용!
        //welcomLabel.font = UIFont(name: "NotoSansKR-Medium", size: 17 )
        welcomLabel.font = UIFont(name: "S-CoreDream-9Black", size: 17)
        //welcomLabel.font = UIFont().mainBlack
        
        //backupLabel.text = NSLocalizedString("data_backup", tableName: "Setting", bundle: .main, value: "", comment: "")
        //backupLabel.text = LocalizableStrings.data_backup.localizedSetting
        
    }
    
    
    


}

