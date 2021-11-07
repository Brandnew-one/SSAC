//
//  DetailViewController.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit

class DetailViewController: UIViewController {
    
    var castArray: [Cast] = []
    var movieData: MovieModel = MovieModel()
    var overviewTrigger: Bool = false
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMovieActorData()
        
        navigationItem.title = "출연/제작"
        
        // Section Header 설정!
        movieNameLabel.text = movieData.titleData
        if let url = URL(string: "https://image.tmdb.org/t/p/original/" + movieData.imageData) {
            posterImageView.kf.setImage(with: url)
        }
        else {
            posterImageView.image = UIImage(systemName: "star")
        }
        
        
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func fetchMovieActorData() {
        DispatchQueue.global().async {
            TdmbCreditManager.shared.fetchWeatherData(movieID: self.movieData.movieID) { code, json in
                for item in json["cast"].arrayValue {
                    let name = item["name"].stringValue
                    let chracter = item["character"].stringValue
                    let image = item["profile_path"].stringValue
                    let data = Cast(actorName: name, actorImage: image, character: chracter)
                    self.castArray.append(data)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc
    func overviewButtonClicked() {
        overviewTrigger = !overviewTrigger
        tableView.reloadRows(at: [ IndexPath(item: 0, section: 0) ], with: .fade)
    }
}




extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return castArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else {
                return UITableViewCell()
            }
            
            let row = castArray[indexPath.row]
            
            //Poster Set
            if let url = URL(string: "https://image.tmdb.org/t/p/original/" + row.actorImage) {
                cell.detailImageView.kf.setImage(with: url)
            }
            else {
                cell.detailImageView.image = UIImage(systemName: "star")
            }
            
            cell.actorNameLabel.text = row.actorName
            cell.characterLabel.text = row.character
            
            return cell
        }
        
        else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as? OverViewTableViewCell else {
                return UITableViewCell()
            }
            
            cell.overViewLabel.text = movieData.movieOverView
            if overviewTrigger {
                cell.overViewLabel.numberOfLines = 0
            }
            else {
                cell.overViewLabel.numberOfLines = 2
            }
            
            cell.overViewButton.addTarget(self, action: #selector(overviewButtonClicked), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            return 125
        }
        
        else {
            return UITableView.automaticDimension
        }
    }
        
}

