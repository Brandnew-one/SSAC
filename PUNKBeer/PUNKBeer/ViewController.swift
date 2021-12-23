//
//  ViewController.swift
//  PUNKBeer
//
//  Created by 신상원 on 2021/12/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let headerView = UIView()
    let contentView = ContentView()
    let descriptionView = DescriptionView()
    let bottomView = BottomView()
    
    let apiService = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setScrollView()
        setBottomView()
        setHeaderView()
        
        setDescriptionView()
        setContentView()
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .magenta
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-70)
        }
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
            make.width.equalTo(view.frame.width)
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1000)
        }
    }
    
    func setBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .lightGray
        bottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
    }
    
    func setDescriptionView() {
        scrollView.addSubview(descriptionView)
        descriptionView.clipsToBounds = true
        descriptionView.layer.cornerRadius = 10
        descriptionView.backgroundColor = .systemCyan
        descriptionView.beerName.text = "TEST BEER"
        descriptionView.beerDescription.text = "어렵다 어려워\n제발 그냥 좀 되라~"
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(-50)
//            $0.bottom.equalTo(contentView.snp.top).offset(-20)
            $0.height.equalTo(200)
            $0.leading.equalTo(view.snp.leading).offset(30)
            $0.trailing.equalTo(view.snp.trailing).offset(-30)
        }
    }
    
    func setContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .systemBrown
        contentView.pairTitleLabel.text = "PAIR"
        contentView.pairContentLabel.text = "테스트중입니다\n테스트중입니다."
        contentView.tipsTitleLabel.text = "TIPS"
        contentView.tipsContentLabel.text = "테스트중입니다\n테스트중입니다."
        contentView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(descriptionView.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-10)
//            $0.edges.equalTo(0)
//            $0.width.equalTo(view.frame.width)
//            $0.left.right.top.equalToSuperview()
//            $0.height.equalTo(1000)
        }
    }
    
    
    
    func setHeaderView() {
        scrollView.addSubview(headerView)
        headerView.backgroundColor = .systemMint
        
        let imageView = UIImageView()
        scrollView.addSubview(imageView)
        imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "star.fill")
        
        headerView.snp.makeConstraints {
            $0.left.right.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(250)
        }
        
        imageView.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(headerView)
        }
        
    }

}

