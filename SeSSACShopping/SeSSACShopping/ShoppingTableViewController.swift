//
//  ShoppingTableViewController.swift
//  SeSSACShopping
//
//  Created by 신상원 on 2021/10/13.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var list: [ShoppingList] = [] {
       didSet {
           saveData()
         }
    }
    
    //Hearder 에 있는 뷰객체 이므로 여기서 연결하는거임!
    @IBOutlet weak var textFieldView: UITextField!
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var topHeaderViewButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topHeaderView.layer.cornerRadius = 10
        topHeaderView.clipsToBounds = true
        loadData()
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        //옵셔널 바인딩
        if let text = textFieldView.text {
            
            let checkBuy: Bool = false
            let checkStar: Bool = false
            let check: Check = Check(checkBuy: checkBuy, checkStar: checkStar)
            let shoppingList = ShoppingList(checkList: text, check: check)
            list.append(shoppingList)
            print(list)
        }
        else {
            print(" ")
        }
    }
    
    func loadData() {
        
        let userDefaults = UserDefaults.standard
        
        var shop = [ShoppingList]()
        
        if let data = userDefaults.object(forKey: "shopListBuy") as? [[String:Any]] {
            for datum in data {
                guard let content = datum["Content"] as? String else {return}
                guard let checkBuy = datum["CheckBuy"] as? Bool else {return}
                shop.append(ShoppingList(checkList: content, check: Check(checkBuy: checkBuy, checkStar: false)))
            }
        }
        
        if let data2 = userDefaults.object(forKey: "shopListStar") as? [[String:Any]] {
            for datum in data2 {
                guard let content = datum["Content"] as? String else {return}
                guard let checkStar = datum["CheckStar"] as? Bool else {return}
                //shop 에 저장된 이름 찾아서 checkstar 값 넣어주고 종료
                for i in 0...shop.count - 1 {
                    if shop[i].checkList == content {
                        shop[i].check.checkStar = checkStar
                        break
                    }
                }
            }
        }
        
        self.list = shop
        
    }
    
    //button 에 의해서 list에 정보가 저장되고, didSet에 의해서 saveData 가 호출된다.
    func saveData() {
        
        var shop: Array<[String:Any]> = []
        
        for listData in list {
            let data: [String:Any] = [
                "Content": listData.checkList,
                "CheckBuy": listData.check.checkBuy
            ]
            shop.append(data)
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(shop, forKey: "shopListBuy")
        
        
        var shop2: Array<[String:Any]> = []
        
        for listData in list {
            let data: [String:Any] = [
                "Content": listData.checkList,
                "CheckStar": listData.check.checkStar
            ]
            shop2.append(data)
        }
        userDefaults.set(shop2, forKey: "shopListStar")
        
        tableView.reloadData()
    }
    
    
    
    @IBAction func keyboardClosed(_ sender: UITextField) {
    }
    
    
    //섹션의 수( default = 1) : numberOfSections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //UITableViewCell 타입이 들어오는건 알겠는데 (우리가 만든 custom cell 의 슈퍼클래스)
        //혹시 ShoppingTableViewCell 로 다운캐스팅이 되니?
        //guard 를 통해서 캐스팅이 안되면 UITalbeViewCell 타입으로 줘~
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.identifier, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        let row = list[indexPath.row]
        
        cell.shopLabel.textColor = .black
        cell.shopLabel.font = .systemFont(ofSize: 20, weight: .bold)
        cell.shopLabel.text = row.checkList
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    
    //스와이프에 어떤 기능을 추가?
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if editingStyle == .delete {
                list.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
}
