//
//  HomeViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBarItem.title = LocalizableStrings.tab_home.localized //변화 없음
        //Tab bar, navigation bar 둘다 바뀜
        //title = LocalizableStrings.tab_home.localized
        self.tabBarController?.tabBar.items![0].title = LocalizableStrings.tab_home.localized
        self.tabBarController?.tabBar.items![1].title = LocalizableStrings.tab_search.localized
        self.tabBarController?.tabBar.items![2].title = LocalizableStrings.tab_calendar.localized
        self.tabBarController?.tabBar.items![3].title = LocalizableStrings.tab_setting.localized
    }
    
    
    
    @IBAction func plusButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Content", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    

}
