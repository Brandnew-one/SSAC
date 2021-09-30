//
//  ViewController.swift
//  SSACMOVIE
//
//  Created by 신상원 on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var movieOne: UIImageView!
    @IBOutlet weak var movieTwo: UIImageView!
    @IBOutlet weak var movieThree: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieOne.layer.borderWidth = 1
        movieOne.layer.masksToBounds = false
        movieOne.layer.borderColor = UIColor.black.cgColor
        movieOne.layer.cornerRadius = movieOne.frame.height/2
        movieOne.clipsToBounds = true
        
        movieTwo.layer.borderWidth = 1
        movieTwo.layer.masksToBounds = false
        movieTwo.layer.borderColor = UIColor.black.cgColor
        movieTwo.layer.cornerRadius = movieOne.frame.height/2
        movieTwo.clipsToBounds = true
        
        movieThree.layer.borderWidth = 1
        movieThree.layer.masksToBounds = false
        movieThree.layer.borderColor = UIColor.black.cgColor
        movieThree.layer.cornerRadius = movieOne.frame.height/2
        movieThree.clipsToBounds = true
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let posterArray: Array<UIImage> = [#imageLiteral(resourceName: "poster10"), #imageLiteral(resourceName: "poster4"), #imageLiteral(resourceName: "poster7"), #imageLiteral(resourceName: "poster8"), #imageLiteral(resourceName: "poster10"), #imageLiteral(resourceName: "poster4"), #imageLiteral(resourceName: "poster9"), #imageLiteral(resourceName: "poster5"), #imageLiteral(resourceName: "poster1")]
        posterImageView.image = posterArray[Int.random(in: 0...8)]
    }
    
    
    
    
}

