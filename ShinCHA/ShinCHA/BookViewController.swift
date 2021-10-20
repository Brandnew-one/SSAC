//
//  BookViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/19.
//

import UIKit

class BookViewController: UIViewController {
    
    let tvShowInformation = TvShowInformation()
    
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        //navigationItem.leftBarButtonItem =
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        bookCollectionView.collectionViewLayout = layout
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    

}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tvShowInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let book = tvShowInformation.tvShow[indexPath.item]
        
        cell.titleLabel.text = book.title
        cell.titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        cell.titleLabel.textColor = .white
        
        cell.rateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        cell.rateLabel.text = "\(book.rate)"
        
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        //RGB 조합해서 만들기
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        cell.backgroundColor = randomColor
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        
        let url = URL(string: book.backdropImage)
        let data = try? Data(contentsOf: url!)
        cell.movieImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    
}
