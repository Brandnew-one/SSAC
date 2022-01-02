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
    let imageView = UIImageView()
    let containerView = UIView()
    let imageContainerView = UIView()
    
    let descriptionView = DescriptionView()
    let contentView = ContentView()
    let bottomView = BottomView()
    
    var beerViewModel = BeerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupConstraints()
        setupInformation()
        
        bottomView.refreshButton.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
        descriptionView.detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func refreshButtonClicked() {
        setupInformation()
    }
    
    @objc
    func detailButtonClicked() {
        if beerViewModel.detailBool.value {
            descriptionView.beerDescription.numberOfLines = 4
            beerViewModel.detailBool.value = false
        }
        else {
            descriptionView.beerDescription.numberOfLines = 0
            beerViewModel.detailBool.value = true
        }
    }
    
    func setupView() {
        [scrollView, imageView, bottomView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(containerView)
        
        [imageContainerView, descriptionView, contentView].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
//        scrollView.alwaysBounceVertical = true
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(imageContainerView.snp.bottom)
        }
        

        
        descriptionView.backgroundColor = .orange
        descriptionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(260)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        contentView.backgroundColor = .blue
        contentView.tipsContentLabel.backgroundColor = .systemGray
        contentView.tipsTitleLabel.backgroundColor = .systemGray
        contentView.pairContentLabel.backgroundColor = .systemGray
        contentView.pairTitleLabel.backgroundColor = .systemGray
        contentView.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setupInformation() {
        beerViewModel.fetchRandomBeer()
        beerViewModel.randomBeer.bind { beer in
            let url = URL(string: beer.first?.imageURL ?? "https://images.punkapi.com/v2/keg.png")
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
                self.descriptionView.beerName.text = beer.first?.name
                self.descriptionView.beerDescription.text = beer.first?.beerDescription
                self.contentView.pairTitleLabel.text = beer.first?.foodPairing.first ?? "None"
                self.contentView.pairContentLabel.text = beer.first?.beerDescription
                self.contentView.tipsContentLabel.text = beer.first?.brewersTips
                self.contentView.tipsTitleLabel.text = beer.first?.contributedBy
            }
        }
    }
}

