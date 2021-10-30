//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/30.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchLabel1: UILabel!
    @IBOutlet weak var searchLabel2: UILabel!
    @IBOutlet weak var searchLabel3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
