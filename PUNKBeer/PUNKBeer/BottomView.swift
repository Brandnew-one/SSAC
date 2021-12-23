//
//  BottomView.swift
//  PUNKBeer
//
//  Created by 신상원 on 2021/12/23.
//

import UIKit
import SnapKit

class BottomView: UIView {
    
    let shareButton = UIButton()
    let refreshButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    //Layout 설정
    func loadLayout() {
        self.addSubview(shareButton)
        self.addSubview(refreshButton)
        
        refreshButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.width.equalTo(refreshButton.snp.height)
        }
        
        shareButton.snp.makeConstraints {
            $0.leading.equalTo(refreshButton.snp.trailing).offset(18)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    //Button 세부설정
    func setButton() {
        refreshButton.backgroundColor = .systemMint
        refreshButton.clipsToBounds = true
        refreshButton.layer.cornerRadius = 10
        refreshButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        shareButton.backgroundColor = .systemMint
        shareButton.clipsToBounds = true
        shareButton.layer.cornerRadius = 10
        shareButton.setTitle("Share BEER", for: .normal)
    }
    
}
