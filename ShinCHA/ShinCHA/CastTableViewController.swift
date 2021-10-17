//
//  CastTableViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/17.
//

import UIKit

class CastTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClicked))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    // 셀의 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.castImageView.image = UIImage(systemName: "chevron.backward")
        cell.nameLabel.text = "Shin Sang Won"
        cell.roleLabel.text = "저는 말하는 감자입니다..."
        
        return cell
        
    }
    
    //3. 셀의 높이 : heightForRowAt (default = 44)
    //섹션마다, 셀마다 높이를 다르게 설정 가능
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
}
