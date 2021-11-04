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
    var projects: Results<UserProject>!
    
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
        projects = localRealm.objects(UserProject.self)
        
        format.dateFormat = "yyyyMMdd"
        yesterdayDate = calender.date(byAdding: .day, value: -1, to: Date())
        yesterday = format.string(from: yesterdayDate!)
        
        print(yesterday)
        print("Realm is located at: ", localRealm.configuration.fileURL!)
        dateTextField.keyboardType = .numberPad
        
        //앱이 처음 실행된 경우
        if projects.count == 0 {
            print("앱을 처음 실행시켰네요~!")
            fetchBoxOfficeData3()
        }
        
        //날짜가 바뀐 경우
        else if projects.filter("yesterdayDate = %@",yesterday).isEmpty {
            print("날짜가 변경되었네요~!")
            fetchBoxOfficeData3()
        }
    }
    
//    func fetchBoxOfficeData() {
//
//        BoxOfficeManager.shared.fetchBoxOfficeData(date: yesterday) { code, json in
//
//            for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//                let rank = item["rank"].stringValue
//                let movieName = item["movieNm"].stringValue
//                let openDate = item["openDt"].stringValue
//                //let data = BoxOffice(movieRank: rank, movieName: movieName, movieDate: openDate)
//                //self.boxOfficeData.append(data)
//                let task = UserBoxOffice(yesterdayDate: self.yesterday, movieRank: rank, movieTitle: movieName, movieDate: openDate)
//                try! self.localRealm.write {
//                    self.localRealm.add(task)
//                }
//            }
//            self.tableView.reloadData()
//        }
//    }
    
    
    func fetchBoxOfficeData3() {
        print("네트워크 통신을 통해 받아옵니다~!")
        BoxOfficeManager.shared.fetchBoxOfficeData(date: yesterday) { code, json in
            try! self.localRealm.write {
                var taskList: [UserTask] = []
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = item["rank"].stringValue
                    let movieName = item["movieNm"].stringValue
                    let openDate = item["openDt"].stringValue
                    let task = UserTask(movieRank: rank, movieTitle: movieName, movieDate: openDate)
                    taskList.append(task)
                }
                let project = UserProject(yesterdayDate: self.yesterday, boxOffice: taskList)
                self.localRealm.add(project)
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        yesterday = dateTextField.text ?? "20041111"
        fetchBoxOfficeData3()
    }
    
    @IBAction func keyBoardClosed(_ sender: UITextField) {
    }
    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}


extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return boxOfficeData.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        //let row = boxOfficeData[indexPath.row]
        let result = projects.filter("yesterdayDate = %@",yesterday).first?.boxOffice[indexPath.row]
        //let result = localRealm.objects(UserProject.self).filter("yesterdayDate == \(yesterday)").first?.boxOffice[indexPath.row]
        
        cell.rankLabel.text = result?.movieRank
        cell.titleLabel.text = result?.movieTitle
        cell.dateLabel.text = result?.movieDate
        
        return cell
    }
    
}
