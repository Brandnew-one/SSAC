//
//  ContentView.swift
//  PUNKBeer
//
//  Created by 신상원 on 2021/12/23.
//

import UIKit
import SnapKit

class ContentView: UIView {
    
    let pairTitleLabel = UILabel()
    let pairContentLabel = UILabel()
    let tipsTitleLabel = UILabel()
    let tipsContentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func loadLayout() {
        [pairTitleLabel, pairContentLabel, tipsTitleLabel, tipsContentLabel].forEach {
            self.addSubview($0)
        }
        
        pairTitleLabel.font = .boldSystemFont(ofSize: 25)
        pairTitleLabel.numberOfLines = 1
        pairTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(8)
        }
        
        pairContentLabel.font = .systemFont(ofSize: 18)
        pairContentLabel.numberOfLines = 0
        pairContentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalTo(pairTitleLabel.snp.bottom).offset(8)
        }
        
        tipsTitleLabel.font = .boldSystemFont(ofSize: 25)
        tipsTitleLabel.numberOfLines = 1
        tipsTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalTo(pairContentLabel.snp.bottom).offset(200)
        }
        
        tipsContentLabel.font = .systemFont(ofSize: 18)
        tipsContentLabel.numberOfLines = 0
        tipsContentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalTo(tipsTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-18)
        }
    }
}
