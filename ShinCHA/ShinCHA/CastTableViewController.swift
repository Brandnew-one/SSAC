//
//  CastTableViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/17.
//

import UIKit

class CastTableViewController: UITableViewController {
    
    var castSpace: TvShow?
    var castArray: Array<String> = []
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var hearderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "출연/제작"
        
        // Section Header 설정!
        hearderLabel.text = castSpace?.title
        let url = URL(string: castSpace?.backdropImage ?? "")
        let data = try? Data(contentsOf: url!)
        headerImageView.image = UIImage(data: data!)
        
    }
    
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    // 섹션 별로 셀의 개수 설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //For overview
        if section == 0 {
            return 1
        }
        //For star
        else {
            return castArray.count
        }
    }
    
    
    
    // 셀의 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell else {
                return UITableViewCell()
            }
            
            let url = URL(string: castSpace?.backdropImage ?? "")
            let data = try? Data(contentsOf: url!)
            
            cell.castImageView.image = UIImage(data: data!)
            cell.nameLabel.text = castArray[indexPath.row]
            cell.roleLabel.text = "저는 말하는 감자입니다..."
            
            return cell
        }
        
        else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            
            //cell.overviewLabel.text = castSpace?.overview
            //cell.overviewLabel.text = "왜 왼쪽으로 숨는것이냐?"
            
            return cell
            
        }
        
    }
    
    
    //3. 셀의 높이 : heightForRowAt (default = 44)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            return 125
        }
        
        else {
            return 125
        }
    }
    
    
}
