//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by 신상원 on 2021/11/02.
//

import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shoppingTextField: UITextField!
    
    let localRealm = try! Realm()
    var tasks: Results<UserList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        print("Realm:",localRealm.configuration.fileURL!)
        
        tasks = localRealm.objects(UserList.self)
        //print(tasks)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()
    }
    
    
    @IBAction func keyBoardClosed(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let task = UserList(shoppingCheck: false, shoppingTitle: shoppingTextField.text ?? "입력되지 않았습니다.", shoppingFavorite: false)
        // Realm 에 위의 task 를 추가한다
        try! localRealm.write {
            localRealm.add(task)
        }
        tableView.reloadData()
    }
    
    @objc
    func checkButtonClicked(checkButton:UIButton) {
        //tasks[checkButton.tag].shoppingCheck = !tasks[checkButton.tag].shoppingCheck
        //이렇게 해줘야 한다!!!
        try! localRealm.write {
            tasks[checkButton.tag].shoppingCheck = !tasks[checkButton.tag].shoppingCheck
        }
        
        tableView.reloadData()
    }
    
    @objc
    func starButtonClicked(starButton:UIButton) {
        //tasks[starButton.tag].shoppingFavorite = !tasks[starButton.tag].shoppingFavorite
        try! localRealm.write {
            tasks[starButton.tag].shoppingFavorite = !tasks[starButton.tag].shoppingFavorite
        }
        tableView.reloadData()
    }
    
    @IBAction func sortButtonClicked(_ sender: UIButton) {
        showActionSheet {
            print("할일을 기준으로 정렬합니다.")
            self.tasks = self.localRealm.objects(UserList.self).sorted(byKeyPath: "shoppingCheck", ascending: false)
            self.tableView.reloadData()
        } titleAction: {
            print("제목을 기준으로 정렬합니다.")
            self.tasks = self.localRealm.objects(UserList.self).sorted(byKeyPath: "shoppingTitle", ascending: true)
            self.tableView.reloadData()
        } starAction: {
            print("즐겨찾기를 기준으로 정렬합니다.")
            self.tasks = self.localRealm.objects(UserList.self).sorted(byKeyPath: "shoppingFavorite", ascending: false)
            self.tableView.reloadData()
        }

    }
    

}


extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        cell.shoppingLabel.textColor = .black
        cell.shoppingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        cell.shoppingLabel.text = row.shoppingTitle
        
        if !row.shoppingCheck {
            //cell.checkButton.imageView?.image = UIImage(systemName: "checkmark.circle")
            //setImage 로 이미지 설정하지 않으면 이미지를 불러오지 못해서 오류가 날 수 있다.
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        else {
            //cell.checkButton.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked(checkButton:)), for: .touchUpInside)
        
        
        if !row.shoppingFavorite {
            //cell.starButton.imageView?.image = UIImage(systemName: "star")
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else {
            //cell.starButton.imageView?.image = UIImage(systemName: "star.fill")
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonClicked(starButton:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = tasks[indexPath.row]
        try! localRealm.write {
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
}
