//
//  DescriptionView.swift
//  PUNKBeer
//
//  Created by 신상원 on 2021/12/23.
//

import UIKit
import SnapKit

class DescriptionView: UIView {
    
    let beerName = UILabel()
    let beerDescription = UILabel()
    let detailButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func loadLayout() {
        [beerName, beerDescription, detailButton].forEach {
            self.addSubview($0)
        }
        
        beerName.font = .boldSystemFont(ofSize: 25)
        beerName.textAlignment = .center
        beerName.backgroundColor = .white
        beerName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.trailing.leading.equalToSuperview().inset(15)
        }
        
        beerDescription.font = .systemFont(ofSize: 18)
        beerDescription.numberOfLines = 4
        beerDescription.backgroundColor = .systemGray2
        beerDescription.snp.makeConstraints {
            $0.top.equalTo(beerName.snp.bottom).offset(8)
            $0.trailing.leading.equalToSuperview().inset(15)
        }
        
        detailButton.setTitle("more", for: .normal)
        detailButton.backgroundColor = .systemGray3
        detailButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.top.equalTo(beerDescription.snp.bottom).offset(8)
            $0.trailing.leading.equalToSuperview().inset(15)
        }
    }
    
}
