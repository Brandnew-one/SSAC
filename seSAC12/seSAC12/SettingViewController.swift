//
//  SettingViewController.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/15.
//

import UIKit

class SettingViewController: UIViewController {
    
    var name: String?
    
    let firstSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    
    let secondSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    
    let thirdSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        view.backgroundColor = .white
        
        //StackView
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalTo(view)
//            $0.leading.equalTo(20)
//            $0.trailing.equalTo(20)
//            $0.width.equalTo(view.snp.width)
            $0.width.equalTo(view.snp.width).multipliedBy(1.0 / 1.0).inset(20)
            $0.height.equalTo(80)
        }
        
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
//        UIView.animate(withDuration: 1) {
//            self.firstSquareView.alpha = 1
//            self.secondSquareView.alpha = 1
//            self.thirdSquareView.alpha = 1
//        }
        
        UIView.animate(withDuration: 1) {
            self.firstSquareView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 1) {
                    self.thirdSquareView.alpha = 1
                }
            }
        }
    }
    
    
    
    
}
