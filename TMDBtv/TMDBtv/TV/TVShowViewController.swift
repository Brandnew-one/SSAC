//
//  TVShowViewController.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/21.
//

import UIKit
import SnapKit

class TVShowViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var searchController = UISearchController(searchResultsController: TVSearchViewController())
    var tvshowViewModel = TVShowViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self // 다른 view 에서 결과를 보여줄 수 있도록 설정
        searchController.searchBar.delegate = self // 서치바 눌렀을 떄만 통신 되도록 설정
        
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        setFlowLayout()
        
        tvshowViewModel.fetchTrendingWeek()
        tvshowViewModel.tvTrendingWeek.bind { trending in
            self.collectionView.reloadData()
        }
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

//MVVM
extension TVShowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvshowViewModel.numberOfItemsInSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = tvshowViewModel.cellForItemAt(indexPath: indexPath)
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

extension TVShowViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        print(#function)
    }
}

extension TVShowViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchController.searchBar.text!)
        if let resultsController = searchController.searchResultsController as? TVSearchViewController {
            resultsController.tvSearchViewModel.fetchTvSearch(query: searchController.searchBar.text!)
            
            resultsController.tvSearchViewModel.tvSearch.bind { search in
                resultsController.collectionView.reloadData()
            }
        }
    }
}
