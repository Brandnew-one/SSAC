//
//  TrendViewController.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class TrendViewController: UIViewController {
    
    var movieData: [MovieModel] = [] {
        didSet {
            print(movieData.count)
        }
    }
    var maxCount = 0
    var startPage = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        fetchMovieData()
    }
    
    func fetchMovieData() {
        TdmbManager.shared.fetchWeatherData(page: startPage) { code, json in
            //print(json)
            self.maxCount = json["total_results"].intValue
            for item in json["results"].arrayValue {
                let title = item["original_title"].stringValue
                let image = item["poster_path"].stringValue
                let userRating = "\(item["vote_average"].doubleValue)"
                let relaseDate = item["release_date"].stringValue
                let mediaType = item["original_title"].stringValue
                let subTitle = item["original_title"].stringValue
                let movieID = "\(item["id"].intValue)"
                let movieOverView = item["overview"].stringValue
                
                let data = MovieModel(mediaType: mediaType, titleData: title, subtitle: subTitle, imageData: image, userRatingData: userRating, releaseDate: relaseDate, movieID: movieID, movieOverView: movieOverView)
                
                self.movieData.append(data)
            }
            self.tableView.reloadData()
        }
    }
    
    @objc
    func overViewButtonClicked(selectButton: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.movieKey = movieData[selectButton.tag].movieID
            
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func boxOfficeButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BoxOfficeViewController") as! BoxOfficeViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else {
            return UITableViewCell()
        }
        
        let row = movieData[indexPath.row]
        
        //Poster Set
        if let url = URL(string: "https://image.tmdb.org/t/p/original/" + row.imageData) {
            cell.movieImageView.kf.setImage(with: url)
        }
        else {
            cell.movieImageView.image = UIImage(systemName: "star")
        }
        
        
        cell.titleLabel.text = row.titleData
        //cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        cell.originTitleLabel.text = row.subtitle
        //cell.originTitleLabel.font = UIFont.systemFont(ofSize: 18)
        //cell.originTitleLabel.textColor = .gray
        
        cell.userRateLabel.text = row.userRatingData
        //cell.userRateLabel.font = UIFont.systemFont(ofSize: 15)
        //cell.userRateLabel.textColor = .gray
        
        cell.mediaTypeLabel.text = row.mediaType
        cell.overViewButton.tag = indexPath.row
        cell.overViewButton.addTarget(self, action: #selector(overViewButtonClicked(selectButton:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let row = movieData[indexPath.row]
        vc.movieID = row.movieID
        vc.movieImage = row.imageData
        vc.movieName = row.titleData
        vc.movieOverView = row.movieOverView
        
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = "뒤로"
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < maxCount {
                startPage += 1
                fetchMovieData()
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }

}
