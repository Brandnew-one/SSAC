//
//  SearchViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tabBarItem.title = LocalizableStrings.tab_search.localized
        //title = LocalizableStrings.tab_search.localized
    }
    

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.searchImageView.backgroundColor = .blue
        cell.contentLabel.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용"
        cell.dateLabel.text = "2021.11.02"
        cell.titleLabel.text = "제목제목제목제목제목제목제목제목제목제목제목"
        
        return cell
    }
    
}
