//
//  OverviewTableViewCell.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/19.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    static let identifier = "OverviewTableViewCell"
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
