//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by 신상원 on 2021/11/02.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var shoppingLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
