//
//  OverViewTableViewCell.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {

    static let identifier = "OverViewTableViewCell"
    
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var overViewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
