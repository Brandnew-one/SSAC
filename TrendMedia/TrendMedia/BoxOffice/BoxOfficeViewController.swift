//
//  BoxOfficeViewController.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/11/02.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class BoxOfficeViewController: UIViewController {
    
    var boxOfficeData: [BoxOffice] = [] {
        didSet {
        }
    }

    var date: String = "20041111"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClicked))
        tableView.delegate = self
        tableView.dataSource = self
        fetchBoxOfficeData()

    }
    
    func fetchBoxOfficeData() {
        BoxOfficeManager.shared.fetchBoxOfficeData(date: date) { code, json in
            //print(json)
            for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                let rank = item["rank"].stringValue
                let movieName = item["movieNm"].stringValue
                let openDate = item["openDt"].stringValue
                let data = BoxOffice(movieRank: rank, movieName: movieName, movieDate: openDate)
                self.boxOfficeData.append(data)
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        boxOfficeData.removeAll()
        date = dateTextField.text ?? "20041111"
        fetchBoxOfficeData()
    }
    
    @IBAction func keyBoardClosed(_ sender: UITextField) {
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    

}


extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        let row = boxOfficeData[indexPath.row]
        cell.rankLabel.text = row.movieRank
        cell.titleLabel.text = row.movieName
        cell.dateLabel.text = row.movieDate
        
        return cell
    }
    
    
}
