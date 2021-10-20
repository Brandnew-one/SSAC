//
//  BookCollectionViewCell.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/19.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    

}
