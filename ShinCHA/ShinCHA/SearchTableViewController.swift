//
//  SearchTableViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/17.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let tvShowInformation = TvShowInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //1. 셀의 개수 : numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvShowInformation.tvShow.count
    }
    
    //2. 셀의 디자인 및 데이터 처리 (데이터에 따라 디자인이 달라질 수 있음) : cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        let url = URL(string: row.backdropImage)
        let data = try? Data(contentsOf: url!)
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        cell.releaseDateLabel.text = "\(row.releaseDate)"
        cell.releaseDateLabel.font = UIFont.systemFont(ofSize: 18)
        //cell.releaseDateLabel.textColor = .gray
        
        cell.overViewLabel.text = row.overview
        cell.overViewLabel.font = UIFont.systemFont(ofSize: 15)
        cell.overViewLabel.numberOfLines = 2
        cell.overViewLabel.textColor = .gray
        
        cell.posterImageView.image = UIImage(data: data!)

        return cell
        
    }
    
    //3. 셀의 높이 : heightForRowAt (default = 44)
    //섹션마다, 셀마다 높이를 다르게 설정 가능
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125 //dynamic 하게 설정할 이유는 없을것 같다.
    }
    
    //셀을 클릭했을 때 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("아직은 아무런 기능이 없습니다~")
    }

    


}
