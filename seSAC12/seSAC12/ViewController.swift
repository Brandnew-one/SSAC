//
//  ViewController.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    //Outlet 연결 안하고 코드로 연결하는 법
    let redView: UIView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //코드로 작성된 view들은 View에 직접 추가해줘야 한다.
        greenView.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        
        //clipstobounds -> 모서리를 벗어나는 영역들은 모두 걷어낸다.
//        greenView.clipsToBounds = true
//        greenView.alpha = 0
        
        //view들이 어떤 레이아웃을 가지는가?
        //x,y 위치는 부모 뷰를 기준으로 0,0 시작이다.
        redView.frame = CGRect(x: 30, y: 30, width: 200, height: 200)
        greenView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        redView.backgroundColor = .systemRed
        greenView.backgroundColor = .systemGreen
        blueView.backgroundColor = .systemBlue
        
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
        
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        //Sb - VC 만드는 과정이 없음
        present(DetailViewController(), animated: true, completion: nil)
    }
    

}

