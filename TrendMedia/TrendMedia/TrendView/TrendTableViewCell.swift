//
//  TrendTableViewCell.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
    
    static let identifier = "TrendTableViewCell"
    
    @IBOutlet weak var mediaTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var userRateLabel: UILabel!
    
    @IBOutlet weak var originTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overViewButton: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
