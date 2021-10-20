//
//  MainTableViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/17.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let tvShowInformation = TvShowInformation()
    
    
    @IBOutlet weak var imageSetView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSetView.clipsToBounds = true
        imageSetView.layer.cornerRadius = 10
        imageSetView.layer.shadowOpacity = 0.2
        imageSetView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageSetView.layer.shadowRadius = 10
        imageSetView.layer.masksToBounds = false
        

    }
    
    @objc
    func detailButtonClicked(selectButton: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        print(tvShowInformation.tvShow[selectButton.tag].title)
        //vc.titleLabel?.text = tvShowInformation.tvShow[selectButton.tag].title
        vc.movieLable = tvShowInformation.tvShow[selectButton.tag].title
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    //섹션의 수( default = 1) : numberOfSections
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
    
    //섹션의 타이틀 : titleForHeaderInSection
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "섹션 타이틀"
//    }
    
    
    
    //1. 셀의 개수 : numberOfRowsInSection -> 설정하지 않으면 default = 0 인가?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvShowInformation.tvShow.count
    }
    
    //2. 셀의 디자인 및 데이터 처리 (데이터에 따라 디자인이 달라질 수 있음) : cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        
        cell.totalView.clipsToBounds = true
        cell.totalView.layer.cornerRadius = 10
        
        cell.genreLabel.text = row.genre
        cell.releaseDayLabel.text = row.releaseDate
        cell.titileLabel.text = row.title
        
        cell.rateLabel2.text = " \(row.rate) "
        
        cell.overViewLabel.numberOfLines = 1
        cell.overViewLabel.text = row.starring
        
        let url = URL(string: row.backdropImage)
        let data = try? Data(contentsOf: url!)
        cell.posterImageView.image = UIImage(data: data!)
        
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action: #selector(detailButtonClicked(selectButton:)), for: .touchUpInside)
        
        return cell
        
    }
    
    

    
    //3. 셀의 높이 : heightForRowAt (default = 44)
    //섹션마다, 셀마다 높이를 다르게 설정 가능
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    
    
    //셀을 클릭했을 때 기능 -> alert 기능 구현 해보기
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CastTableViewController") as! CastTableViewController
        
        let row = tvShowInformation.tvShow[indexPath.row]
        vc.castSpace = row
        vc.castArray = row.starring.components(separatedBy: ",")
        
        navigationController?.pushViewController(vc, animated: true)
        //Navigation Contorller 스토리 보드에서 설정할 때도 현재 뷰에서 다음 뷰의 뒤로 가기를 설정했음
        navigationItem.backButtonTitle = "뒤로"
        
    }
    

    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ticketButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    


}
