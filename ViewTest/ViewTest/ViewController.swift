//
//  ViewController.swift
//  ViewTest
//
//  Created by 신상원 on 2021/12/19.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let nameCardView = NameCardViewSnap()
    let redView = UIView()
    let blueView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [blueView, redView] .forEach {
            view.addSubview($0)
        }
        
        setBlueView()
        setRedView(mode: true)
        
//        nameCardView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nameCardView)
//        setNameCardView()
        
    }
    
    func setNameCardView() {
        nameCardView.backgroundColor = .systemCyan
        nameCardView.imageView.image = UIImage(systemName: "star")
        nameCardView.imageLabel.text = "TEST"
        nameCardView.contentLabel.text = "PLZ"
        
        NSLayoutConstraint.activate([
            nameCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            nameCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            nameCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    func setBlueView() {
        blueView.backgroundColor = .systemBlue
        blueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(view) //레이아웃 할때 margin 체크하는거
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
    }
    
    //T->Inset, F->Offset
    func setRedView(mode: Bool) {
        redView.backgroundColor = .systemRed
        if mode {
            redView.snp.makeConstraints {
//                $0.top.left.bottom.right.equalToSuperview().inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
                $0.edges.equalTo(blueView).inset(50)
            }
        }
        else {
            redView.snp.makeConstraints {
//                $0.top.equalTo(blueView).offset(50)
//                $0.left.equalTo(blueView).offset(50)
//                $0.right.equalTo(blueView).offset(50)
//                $0.bottom.equalTo(blueView).offset(50)
                $0.edges.equalTo(blueView).offset(50)
            }
        }
    }

}

