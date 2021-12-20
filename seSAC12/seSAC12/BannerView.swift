//
//  BannerView.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/13.
//

import UIKit

class BannerView: UIView {
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    //xib 파일을 만들지 않고, 그냥 코드로 뷰를 구성할 경우
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override init")
        loadLayout()
    }
    
    //실패 가능한 초기화 구문
    required init?(coder: NSCoder) {
        print("required init")
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textColor = .black
        mainLabel.text = "내일 오를 주식을 맞춰주세요!"
        
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "화성 갈거니까"
        
        mainLabel.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 130, height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width - 130, height: 30)
        
        self.addSubview(mainLabel)
        self.addSubview(descriptionLabel)
    }
    
    
}
