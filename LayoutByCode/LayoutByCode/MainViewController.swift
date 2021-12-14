//
//  MainViewController.swift
//  LayoutByCode
//
//  Created by 신상원 on 2021/12/14.
//

import UIKit

class MainViewController: UIViewController {
    
    let deliveryView = BoxSquareView()
    let beminView = BoxSquareView()
    let packView = BoxSquareView()
    let bottomView: [BoxSquareView] = [BoxSquareView(), BoxSquareView(), BoxSquareView(), BoxSquareView()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [deliveryView, beminView, packView].forEach { setting in
            setting.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(setting)
        }
        
        bottomView.forEach { setting in
            setting.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(setting)
        }
        view.backgroundColor = .white
        setDeliveryView()
        setBeminView()
        setPackView()
        setBottomView()
    }
    
    func setDeliveryView() {
        deliveryView.clipsToBounds = true
        deliveryView.layer.cornerRadius = 10
        deliveryView.backgroundColor = .systemGray4
        deliveryView.titleLabel.text = "배달"
        deliveryView.contentLabel.text = "세상은 넓고\n맛집은 많다"
        
        NSLayoutConstraint.activate([
            deliveryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            deliveryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            deliveryView.trailingAnchor.constraint(equalTo: beminView.leadingAnchor, constant: -10),
            deliveryView.heightAnchor.constraint(equalTo: deliveryView.widthAnchor)
        ])
    }
    
    func setBeminView() {
        beminView.clipsToBounds = true
        beminView.layer.cornerRadius = 10
        beminView.backgroundColor = .systemGray4
        beminView.titleLabel.text = "배민"
        beminView.contentLabel.text = "배민원,한 번에\n한 집만 빠르게"
        
        NSLayoutConstraint.activate([
            beminView.widthAnchor.constraint(equalTo: deliveryView.widthAnchor),
            beminView.heightAnchor.constraint(equalTo: beminView.widthAnchor),
            beminView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            beminView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
    }
    
    func setPackView() {
        packView.clipsToBounds = true
        packView.layer.cornerRadius = 10
        packView.backgroundColor = .systemOrange
        packView.titleLabel.text = "포장"
        packView.contentLabel.text = "가까운 가게는 직접 가지러 가지요"
        
        NSLayoutConstraint.activate([
            packView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            packView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            packView.topAnchor.constraint(equalTo: beminView.bottomAnchor, constant: 18),
            packView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.14)
        ])
    }
    
    func setBottomView() {
        bottomView.forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .systemCyan
        }
        bottomView[0].titleLabel.text = "B마트"
        bottomView[0].contentLabel.text = "장보기도\n즉시배달"
        bottomView[1].titleLabel.text = "쇼핑라이브"
        bottomView[1].contentLabel.text = "멕시카나!총\n7천원 혜택"
        bottomView[2].titleLabel.text = "선물하기"
        bottomView[2].contentLabel.text = "배민 상품권\n선물해 보세요"
        bottomView[3].titleLabel.text = "전국별미"
        bottomView[3].contentLabel.text = "동네 맛집을\n넘어서"
        
        NSLayoutConstraint.activate([
            bottomView[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            bottomView[0].topAnchor.constraint(equalTo: packView.bottomAnchor, constant: 18),
            bottomView[0].trailingAnchor.constraint(equalTo: bottomView[1].leadingAnchor, constant: -18),
            bottomView[0].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 27),
            bottomView[0].heightAnchor.constraint(equalTo: bottomView[0].widthAnchor, multiplier: 2/3)
        ])
        
        NSLayoutConstraint.activate([
            bottomView[1].leadingAnchor.constraint(equalTo: bottomView[0].trailingAnchor, constant: 18),
            bottomView[1].topAnchor.constraint(equalTo: packView.bottomAnchor, constant: 18),
            bottomView[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            bottomView[1].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 27),
            bottomView[1].heightAnchor.constraint(equalTo: bottomView[1].widthAnchor, multiplier: 2/3)
        ])
        
        NSLayoutConstraint.activate([
            bottomView[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            bottomView[2].topAnchor.constraint(equalTo: bottomView[0].bottomAnchor, constant: 18),
            bottomView[2].trailingAnchor.constraint(equalTo: bottomView[3].leadingAnchor, constant: -18),
            bottomView[2].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 27),
            bottomView[2].heightAnchor.constraint(equalTo: bottomView[1].widthAnchor, multiplier: 2/3)
        ])
        
        NSLayoutConstraint.activate([
            bottomView[3].leadingAnchor.constraint(equalTo: bottomView[2].trailingAnchor, constant: 18),
            bottomView[3].topAnchor.constraint(equalTo: bottomView[1].bottomAnchor, constant: 18),
            bottomView[3].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            bottomView[3].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 27),
            bottomView[3].heightAnchor.constraint(equalTo: bottomView[2].widthAnchor, multiplier: 2/3)
        ])
    }
    
}
