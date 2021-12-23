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
    let contentView = UIView()
    let descriptionView = DescriptionView()
    let bottomView = BottomView()
    
    let apiService = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scrollView.delegate = self
        setScrollView()
        setBottomView()
        
        setDescriptionView()
        
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-70)
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
    
    func setHeaderView() {
        scrollView.addSubview(headerView)
        headerView.backgroundColor = .systemMint
        
        let imageView = UIImageView()
        headerView.addSubview(imageView)
        imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        headerView.snp.makeConstraints {
            $0.
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
            $0.top.equalTo(imageView.snp.bottom).offset(-50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(180)
        }
        
    }
    
    

}

extension ViewController: UIScrollViewDelegate {
    
}
