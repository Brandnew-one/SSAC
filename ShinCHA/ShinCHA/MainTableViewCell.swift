//
//  MainTableViewCell.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/17.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var releaseDayLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var rateLabel1: UILabel!
    @IBOutlet weak var rateLabel2: UILabel!
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var totalView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
