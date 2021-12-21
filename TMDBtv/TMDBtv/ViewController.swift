//
//  ViewController.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var apiService = APIService()
    var tvData: TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        setFlowLayout()
        
        apiService.requestCast { tv in
            self.tvData = tv
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        let height = UIScreen.main.bounds.height - (spacing * 5)
        layout.itemSize = CGSize(width: width / 3, height: height / 4 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
}

//MVVM 신경쓰지 말고 일단 구현에 중점을 두고 만들어보자
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvData?.results.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = tvData?.results[indexPath.item]
        let url = URL(string: "https://image.tmdb.org/t/p/original" + row!.posterPath)
//        let data = try? Data(contentsOf: url!)
//        cell.imageView.image = UIImage(data: data!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
}
