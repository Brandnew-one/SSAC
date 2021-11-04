//
//  SearchViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tabBarItem.title = LocalizableStrings.tab_search.localized
        //title = LocalizableStrings.tab_search.localized
        
        //Realm 에서 확인했던 모든 데이터를 가져오는 형태
        tasks = localRealm.objects(UserDiary.self)
        //print(tasks)

    }
    
    //ViewWillAppear 에서 설정하면 계속해서 데이터 추가된거 바로 반영할 수 있음
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }
    
    //도큐먼트 폴더 경로에서 이미치를 찾아 UIImage 로 변환하는 과정
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        
        //1. 이미지 저장할 경로 설정 : Document 폴더
        //Desktop/~~/~~/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일 이름 & 최종 경로 설정
        //Desktop/~~/~~/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        //4-1. 이미지 경로 여부 확인 (만약 최종 경로에 동일한 파일이 있는 경우)
        if FileManager.default.fileExists(atPath: imageURL.path) {
            //4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            }
            catch {
                print("이미지 삭제하지 못했습니다.")
            }
        }
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        cell.searchImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).png")
        
        cell.searchImageView.backgroundColor = .blue
        cell.searchImageView.clipsToBounds = true
        cell.searchImageView.layer.cornerRadius = 10
        
        cell.contentLabel.text = row.diaryContent
        cell.dateLabel.text = "\(row.diaryDate)"
        cell.titleLabel.text = row.diaryTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        //but 연결되어 있는 이미지는 삭제되지 않는 문제점이 존재한다.
        try! localRealm.write {
            //순서 중요(Realm 을 먼저 지우면 인덱스가 꼬인다.)
            deleteImageFromDocumentDirectory(imageName: "\(row._id).png")
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
    
    //화면전환 -> 새로운 화면에서 수정할 수 있도록 수정해보기!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*
        let taskToUpdate = tasks[indexPath.row]
        
        //1. 수정 - 레코드에 대한 값 수정
//        try! localRealm.write {
//            taskToUpdate.diaryTitle = "새롭게 수정해봅니다."
//            taskToUpdate.diaryContent = "똥이시니니똥이"
//            tableView.reloadData() //row 만 업데이트 해도 된다.
//        }
        
        //2. 일괄 수정 (테이블에 있는 모든 레이블이 한번에 바뀜)
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "diaryDate")
//            tasks.setValue("새롭게 일기 쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        //3. 수정: PK 기준으로 수정할 때 사용(권장x) -> update 하지 않는 프로퍼티가 통째로 날아가는 문제점
//        try! localRealm.write {
//            let update = UserDiary(value: ["_id" : taskToUpdate._id, "diaryTitle" : "이놈만"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        //4.
        try! localRealm.write {
            localRealm.create(UserDiary.self, value: ["_id" : taskToUpdate._id, "diaryTitle" : "이놈만"], update: .modified)
        }
         */
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let row = tasks[indexPath.row]
        
        vc.titleData = row.diaryTitle
        vc.dateData = "\(row.diaryDate)"
        vc.contentData = row.diaryContent ?? "불러오지 못했습니다."
        vc.imageData = loadImageFromDocumentDirectory(imageName: "\(row._id).png")
        
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
        
        
    }
    
}
