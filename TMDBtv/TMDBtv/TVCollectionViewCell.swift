//
//  TVCollectionViewCell.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/21.
//

import UIKit
import SnapKit

class TVCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TVCollectionViewCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //SuperView의 상,하,좌,우 8 띄우고 채우도록 설정
    func loadLayout() {
        self.backgroundColor = .black
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(8)
            $0.edges.equalToSuperview()
        }
    }
}
