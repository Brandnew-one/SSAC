//
//  MusicView.swift
//  MusicPlayer
//
//  Created by 신상원 on 2022/03/20.
//

import UIKit
import SnapKit

class MusicView: UIView {
    
    let imageView = UIImageView()
    let slider = UISlider()
    let spendTimeLabel = UILabel()
    let totalTimeLabel = UILabel()
    
    let backwardButton = UIButton()
    let playButton = UIButton()
    let forwardButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [imageView, slider, spendTimeLabel, totalTimeLabel, backwardButton, playButton, forwardButton].forEach {
            self.addSubview($0)
        }
        imageView.image = UIImage(named: "sini")
        
        spendTimeLabel.text = "00:00"
        spendTimeLabel.font = .boldSystemFont(ofSize: 15)
        spendTimeLabel.textAlignment = .center
        
        totalTimeLabel.text = "00:00"
        totalTimeLabel.font = .boldSystemFont(ofSize: 15)
        totalTimeLabel.textAlignment = .center
        
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 35)
        backwardButton.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        backwardButton.setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
        forwardButton.setImage(UIImage(systemName: "goforward.15"), for: .normal)
        forwardButton.setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
        
        imageConfig = UIImage.SymbolConfiguration(pointSize: 50)
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playButton.setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
        
    }
    
    // iOS 11 을 기준으로 설정(토이 프로젝트로 모든 기기대응x)
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(400)
            make.centerY.equalToSuperview().offset(-100)
        }
        
        slider.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30)
        }
        
        spendTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        totalTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.leading.equalToSuperview().offset(80)
            make.bottom.equalToSuperview().offset(-70)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalToSuperview().offset(-70)
        }
        
        playButton.snp.makeConstraints { make in
            make.height.width.equalTo(75)
            make.centerY.equalTo(backwardButton)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
