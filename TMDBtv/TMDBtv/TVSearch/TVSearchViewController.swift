//
//  TVSearchViewController.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/29.
//

import UIKit
import SnapKit

class TVSearchViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var tvSearchViewModel = TVSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupView()
        setupConstraints()

        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        setFlowLayout()
    }
    
    func setupView() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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

extension TVSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSearchViewModel.numberOfItemsInSection
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = tvSearchViewModel.cellForItemAt(indexPath: indexPath)
        let url = URL(string: "https://image.tmdb.org/t/p/original" + row.posterPath)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
            }
        }
        return cell
    }

}
