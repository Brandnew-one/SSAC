//
//  SnapDetailViewController.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("Click", for: .normal)
        button.addTarget(self, action: #selector(activateButtonPushClicked), for: .touchUpInside)
        return button
    }()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.text = "13,532원"
        label.textAlignment = .center
        return label
    }()
    
    
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [activateButton, moneyLabel, descriptionLabel, redView].forEach {
//            snapkit에는 prepare에 해당 코드가 있기 때문에 작성하지 않아도 된다.
//            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        view.backgroundColor = .white
        
//        moneyLabel.backgroundColor = .systemYellow
//        moneyLabel.text = "13,532원"
//        moneyLabel.textAlignment = .center
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(view)
            $0.trailingMargin.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view).multipliedBy(0.1)
        }
        
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
//            make.top.equalTo(view)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.bottom.equalTo(view)
            make.edges.equalToSuperview().inset(100)
//            make.bottom.equalTo(400)
        }
        
        redView.snp.updateConstraints { make in
            make.bottom.equalTo(-500)
        }
        
        redView.addSubview(blueView)
        blueView.backgroundColor = .blue
        
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
            
        }
    }
    
    @objc
    func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "Sangwon"
        present(vc, animated: true, completion: nil)
//        present(SettingViewController(), animated: true, completion: nil)
    }
    
    @objc
    func activateButtonPushClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
