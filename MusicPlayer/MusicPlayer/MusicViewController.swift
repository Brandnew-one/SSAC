//
//  MusicViewController.swift
//  MusicPlayer
//
//  Created by 신상원 on 2022/03/20.
//

import AVFoundation
import UIKit
import SnapKit

class MusicViewController: UIViewController {
    
    let musicView = MusicView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(musicView)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        musicView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


