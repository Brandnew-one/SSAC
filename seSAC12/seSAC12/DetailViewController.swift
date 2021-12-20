//
//  DetailViewController.swift
//  seSAC12
//
//  Created by 신상원 on 2021/12/13.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let activateButton = MainActivateButton()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.selectedImage = UIImage(systemName: "trash.fill")
        tabBarItem.image = UIImage(systemName: "trash")
        tabBarItem.title = "디테일"
        
        //forEach 문을 통해서 중복을 줄일 수 있다.
        [titleLabel, contentLabel, activateButton].forEach { setting in
            setting.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(setting)
        }
        view.backgroundColor = .white
        setTitleLabelConstraints()
        setContentLabelConstraints()
        setActivateButtonConstraints()
        setActivateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        Installations.installations().delete { error in
//          if let error = error {
//            print("Error deleting installation: \(error)")
//            return
//          }
//          print("Installation deleted");
//        }
//        
    }
    
    @objc
    func buttonClicked() {
        let vc = TestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setActivateButton() {
        activateButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func setActivateButtonConstraints() {
        view.addSubview(activateButton)
        activateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 200),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }
    
    
    func setTitleLabelConstraints() {
        
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .lightGray
        
        // 설정해주고 view에 추가 해줘야한다! -> 넣어주고 Layout 설정해야한다.
        view.addSubview(titleLabel)
        
        //요것도 설정해줘야 화면에 나오네..
        //SB에서는 false 가 기본값
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Frame-Based-Layout -> 잘 사용하지 않음
//        titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
        
        //NSLayoutConstraints
        //Safe Area 를 생각해주지 않으니까 조심
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        
        //무조건 양수기준임
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
        // view 높이가 100 -> 50 + constant
        
    }
    
    func setContentLabelConstraints() {
        contentLabel.text = "맞춤 정보를 알려드러요"
        contentLabel.font = .boldSystemFont(ofSize: 15)
        contentLabel.textAlignment = .center
        
        view.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: contentLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        
        
//        NSLayoutConstraint(item: contentLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
//
//        //무조건 양수기준임
//        NSLayoutConstraint(item: contentLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        
        NSLayoutConstraint(item: contentLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40).isActive = true
        // view 높이가 100 -> 50 + constant
    }

}
