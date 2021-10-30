//
//  DetailTableViewCell.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
