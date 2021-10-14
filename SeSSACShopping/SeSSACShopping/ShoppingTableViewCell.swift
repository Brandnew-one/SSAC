//
//  ShoppingTableViewCell.swift
//  SeSSACShopping
//
//  Created by 신상원 on 2021/10/13.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    static let identifier = "ShoppingCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        print("check Button Clicked")
        // 값을 확인하는 건 image 를 통해서 할 수 있는데 값을 할당하는건 setImage 로 하지 않으면 설정되지 않음 (why?)
        if checkButton.imageView?.image == UIImage(systemName: "checkmark.circle") {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        else {
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    
    @IBAction func starButtonClicked(_ sender: UIButton) {
        
        print("star Button Clicked")
        // 값을 확인하는 건 image 를 통해서 할 수 있는데 값을 할당하는건 setImage 로 하지 않으면 설정되지 않음 (why?)
        if starButton.imageView?.image == UIImage(systemName: "star") {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
}
