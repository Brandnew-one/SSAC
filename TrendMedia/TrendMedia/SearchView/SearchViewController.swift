//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/30.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class SearchViewController: UIViewController {
    
    var query = ""
    var startPage = 1
    var totalCount = 1
    var movieData: [MovieSearch] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        fetchMovieSearchData()
    }
    
    func fetchMovieSearchData() {
        NaverAPIManager.shared.fetchMovieSearchData(query: query, startPage: startPage) { code, json in
            
            self.totalCount = json["total"].intValue
            
            for item in json["items"].arrayValue {
                let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                let subTitle = item["subtitle"].stringValue
                let image = item["image"].stringValue
                let userRating = item["userRating"].stringValue
                let data = MovieSearch(titleData: title, subtitleData: subTitle, posterData: image, userRatingData: userRating)
                self.movieData.append(data)
            }
            self.tableView.reloadData()
        }
    }
     
    @objc
    func closeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = movieData[indexPath.row]
        if let url = URL(string: row.posterData) {
            cell.searchImageView.kf.setImage(with: url)
        }
        else {
            cell.searchImageView.image = UIImage(systemName: "star")
        }
        
        cell.searchLabel1.text = row.titleData
        cell.searchLabel1.font = UIFont.systemFont(ofSize: 20)
        
        cell.searchLabel2.text = row.subtitleData
        cell.searchLabel2.font = UIFont.systemFont(ofSize: 18)
        cell.searchLabel2.textColor = .gray
        
        cell.searchLabel3.text = row.userRatingData
        cell.searchLabel3.font = UIFont.systemFont(ofSize: 15)
        cell.searchLabel3.numberOfLines = 2
        cell.searchLabel3.textColor = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                fetchMovieSearchData()
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    // 검색 버튼(키보드 리턴키) 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            query = text
            movieData.removeAll()
            startPage = 1
            fetchMovieSearchData()
        }
    }
    
    //취소버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에서 커서 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}
