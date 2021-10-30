//
//  WebViewController.swift
//  TrendMedia
//
//  Created by 신상원 on 2021/10/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var movieKey: String = ""
    var movieURL: String = "" {
        didSet {
            onWebPage()
        }
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieTrailerData() //이 함수가 종료되기 전에 onWebPage 가 먼저 실행되는 문제점!
        //onWebPage()
    }
    
    func fetchMovieTrailerData() {
        TmdbGetMovieManager.shared.fetchMovieTrailerData(movieID: movieKey) { code, json in
            print("1-------------")
            self.movieURL = json["results"][0]["key"].stringValue
            print(self.movieURL)
        }
    }
    
    func onWebPage() {
        let urlRaw = "https://www.youtube.com/watch?v=" + movieURL
        print("2---------------")
        print(urlRaw)
        guard let url = URL(string: urlRaw) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
