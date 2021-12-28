//
//  BoardsViewController.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import UIKit
import SnapKit

class BoardsViewController: UIViewController {
    
    let mainView = BoardsView()
    var boardsViewModel = BoardsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        settupConstraints()
        boardsViewModel.fetchBoards()
        
        boardsViewModel.username.bind { text in
            self.mainView.username.text = text
        }
        
        boardsViewModel.text.bind { text in
            self.mainView.text.text = text
        }
        
        boardsViewModel.email.bind { text in
            self.mainView.email.text = text
        }
        
        boardsViewModel.createdDate.bind { text in
            self.mainView.createdDate.text = text
        }
    }
    
    func setupView() {
        view.addSubview(mainView)
        view.backgroundColor = .systemTeal
    }
    
    func settupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

