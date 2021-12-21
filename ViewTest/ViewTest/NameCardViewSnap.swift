//
//  NameCardViewSnap.swift
//  ViewTest
//
//  Created by 신상원 on 2021/12/21.
//

import UIKit
import SnapKit

class NameCardViewSnap: UIView {
    
    let imageView = UIImageView()
    let imageLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        self.addSubview(imageView)
        self.addSubview(imageLabel)
        self.addSubview(contentLabel)
        
        imageLabel.textAlignment = .center
        contentLabel.textAlignment = .center
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(imageView.snp_height).multipliedBy(0.5)
        }
        
        imageLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp_bottom).offset(18)
            $0.leading.equalToSuperview().offset(18)
            $0.width.equalTo(imageView.snp_width)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp_trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
