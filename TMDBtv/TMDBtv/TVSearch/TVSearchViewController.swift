//
//  TVSearchViewController.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/29.
//

import UIKit
import SnapKit

class TVSearchViewController: UIViewController {
    
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(searchBar)
        searchBar.backgroundColor = .systemGray
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
}
