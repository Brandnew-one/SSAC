//
//  CastTableViewCell.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/17.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
