//
//  TabBarController.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/15.
//

import UIKit

//TabBar, TabBarItem
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정"
        firstVC.tabBarItem.image = UIImage(systemName: "pencil")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "pencail.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        //DetailViewController ViewdidLoad 에서 설정
        let thirdVC = DetailViewController()
        thirdVC.title = "디테일"
        let thiardNav = UINavigationController(rootViewController: thirdVC)
        
        //iOS13 이상부터만 사용가능
        //여러가지 속성 써보면서 익히기!!!!
        let appearence = UITabBarAppearance()
        appearence.configureWithDefaultBackground()
//        appearence.backgroundColor = .red
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
                
        setViewControllers([firstVC, secondVC, thiardNav], animated:  true)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
    
}
