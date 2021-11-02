//
//  BoxOfficeViewController.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/11/02.
//

import UIKit
import Alamofire
import Kingfisher
import RealmSwift
import SwiftyJSON

class BoxOfficeViewController: UIViewController {
    
    var boxOfficeData: [BoxOffice] = [] {
        didSet {
        }
    }
    
    let localRealm = try! Realm()
    var tasks: Results<UserBoxOffice>!
    
    //어제 날짜 설정
    let calender = Calendar.current
    let format = DateFormatter()
    var yesterdayDate: Date? = Date()
    var yesterday: String = ""
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClicked))
        tableView.delegate = self
        tableView.dataSource = self
        tasks = localRealm.objects(UserBoxOffice.self)
        
        format.dateFormat = "yyyyMMdd"
        yesterdayDate = calender.date(byAdding: .day, value: -1, to: Date())
        yesterday = format.string(from: yesterdayDate!)
        print(yesterday)
        
        if tasks.count == 0 {
            fetchBoxOfficeData()
        }
        
        else if tasks[0].yesterdayDate != yesterday {
            for _ in 0...9 {
                let taskDelete = tasks[0]
                try! localRealm.write {
                    localRealm.delete(taskDelete)
                }
            }
            fetchBoxOfficeData()
        }
        
        //fetchBoxOfficeData()
    }
    
    func fetchBoxOfficeData() {
        
        BoxOfficeManager.shared.fetchBoxOfficeData(date: yesterday) { code, json in
            //print(json)
            for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                let rank = item["rank"].stringValue
                let movieName = item["movieNm"].stringValue
                let openDate = item["openDt"].stringValue
                //let data = BoxOffice(movieRank: rank, movieName: movieName, movieDate: openDate)
                //self.boxOfficeData.append(data)
                let task = UserBoxOffice(yesterdayDate: self.yesterday, movieRank: rank, movieTitle: movieName, movieDate: openDate)
                try! self.localRealm.write {
                    self.localRealm.add(task)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //boxOfficeData.removeAll()
        //date = dateTextField.text ?? "20041111"
        //fetchBoxOfficeData()
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
        //return boxOfficeData.count
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        //let row = boxOfficeData[indexPath.row]
        let row = tasks[indexPath.row]
        cell.rankLabel.text = row.movieRank
        cell.titleLabel.text = row.movieTitle
        cell.dateLabel.text = row.movieDate
        
        return cell
    }
    
    
}
