//
//  SearchTableViewCell.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
