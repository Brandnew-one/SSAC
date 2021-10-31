//
//  LocationViewController.swift
//  OpenWeatherApp
//
//  Created by 신상원 on 2021/10/25.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import CoreLocation
import CoreLocationUI

class LocationViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        timeLabel.clipsToBounds = true
        timeLabel.layer.cornerRadius = 10
        
        locationLabel.clipsToBounds = true
        locationLabel.layer.cornerRadius = 10
        locationLabel.textColor = .white
        
        tempLabel.clipsToBounds = true
        tempLabel.layer.cornerRadius = 10
        tempLabel.textColor = .black
        
        humidityLabel.clipsToBounds = true
        humidityLabel.layer.cornerRadius = 10
        humidityLabel.textColor = .black
        
        windLabel.clipsToBounds = true
        windLabel.layer.cornerRadius = 10
        windLabel.textColor = .black
        
        wordLabel.clipsToBounds = true
        wordLabel.layer.cornerRadius = 10
        wordLabel.textColor = .black
        
    }
    
    
    //새로고침 버튼을 눌렀을 때
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus //iOS 14 이상만 사용가능
        }
        
        else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만
        }
        
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청가능 -> 8번 메서드 실행
            checkCurrentLocationAuthorization(authorizationStatus)
        }
        //아예 시스템에서 위치 기능을 끈 경우
        else {
            showAlert(title: "설정으로 이동", message: "권한 허용해주세요", okTitle: "설정으로 가기") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url) { success in
                    }
                }
            }
            print("iOS 위치 서비스를 켜주세요!")
        }
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    //위경도 정보를 통해서 -> 구, 동 으로 변환하기 위해서
    func showTitle(coordi: CLLocationCoordinate2D) {
            let geocoder = CLGeocoder()
            let findLocation = CLLocation(latitude: coordi.latitude, longitude: coordi.longitude)
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
                if let address : [CLPlacemark] = placemarks {
                    
                    let si = address[0].administrativeArea
                    //let gu = address[0].locality
                    let dong = address[0].thoroughfare
                
                    self.locationLabel.text = "\(si!), \(dong!)"
                }
            })
        }
    
    
    func checkUserLocationServicesAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        //14 부터는 정확도 설정이 들어가기 때문에 시스템 설정도 다르게 (8) 에서 보면 열거형의 구성이 추가되어 있음)
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus //iOS 14 이상만 사용가능
        }
        else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만
        }
        
        
        //iOS 위치 서비스 확인 -> 시스템상에서 위치 허용이 되어 있으면 -> 앱 내에서의 위치 권한 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청가능 -> 8번 메서드 실행
            checkCurrentLocationAuthorization(authorizationStatus)
        }
        //아예 시스템에서 위치 기능을 끈 경우
        else {
            showAlert(title: "설정으로 이동", message: "권한 허용해주세요", okTitle: "설정으로 가기") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url) { success in
                        //print("잘 열렸다. \(success)")
                    }
                }
            }
            print("iOS 위치 서비스를 켜주세요!")
        }
    }
    
    
    // 8) 사용자의 권한 상태 확인
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권환 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작! (같이 나와야함)
            
        case .restricted, .denied:
            print("Denied, 설정으로 유도")
            showAlert(title: "설정으로 이동", message: "권한 허용해주세요", okTitle: "설정으로 가기") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url) { success in
                    }
                }
            }
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .authorizedAlways:
            print("Always")
            
        @unknown default:
            print("Default")
        }
        
        if #available(iOS 14.0, *) {
            //정확토 체크: 정확도 감소가 되어 있을 경우, 1시간 4번으로 제한
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("Reduce")
            @unknown default:
                print("Default")
            }
        }
    }
    
    
    // 4) 사용자가 앱 내에서 위치 허용을 한 경우,
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("감사합니다. 허용해 주셔서")
        
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "MM월 dd일 HH시 mm분"
        
        let kr = date.string(from: now)
        timeLabel.text = kr
        
        // 사용자가 앱 내에서 위치 허용을 해줬으니까 현재 위치를 지도의 중심으로 설정한다.
        if let coordinate = locations.last?.coordinate {
            showTitle(coordi: coordinate)
            locationManager.stopUpdatingLocation()
            
            let lon = coordinate.longitude
            let lat = coordinate.latitude
            
            WeatherManager.shared.fetchWeatherData(lon: lon, lat: lat) { code, json in
                switch code {
                    case 200:
                        print(json)
                        let currentTemp = json["main"]["temp"].doubleValue - 273.15
                        self.tempLabel.text = "  지금은\(Int(currentTemp))도에요 "
                        //print(self.tempLabel.text)
                        self.humidityLabel.text = "  \(json["main"]["humidity"].intValue)% 만큼 습해요 "
                        let speed = json["wind"]["speed"].doubleValue
                        self.windLabel.text = "  \(Int(speed))m/s의 바람이 불어요 "

                        let icon = json["weather"][0]["icon"].stringValue
                        let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
                        self.weatherImageView.kf.setImage(with: url)

                    case 400:
                        print(json)
                    
                    default:
                        print("error")
                    }
                }
            }
            
        
        //얘기치 못한 오류 방지 (비행기 모드로 변환되었을 경우) <-> 5번함수와의 기능
        else {
            print("Location Cannot Find")
        }
    }
    
    // 5) 위치 접근에 실패한 경우 (여기에 사용자가 앱내 위치 정보를 거부한것도 포함되는건가? ㅇ)
    // 위치접근을 허용했으나 위치 정보 조회에 실패한 경우 지도에서 어떤화면을 보여줄 것인가?
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("허용 안했어? 왜 오류가 나!")
        
        //위치 허용하지 않은 경우, 건국대 근처 스터디 카페
        let location = CLLocationCoordinate2D(latitude: 37.541366, longitude: 127.067187)
        showTitle(coordi: location)
        
        let lon = 127.067187
        let lat = 37.541366
       
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=fd922ad8ec341506329e9c7d603a0bdc"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.tempLabel.text = " 지금은\(Int(currentTemp))도에요 "
                self.humidityLabel.text = " \(json["main"]["humidity"].intValue)% 만큼 습해요 "
                let speed = json["wind"]["speed"].doubleValue
                self.windLabel.text = " \(Int(speed))m/s의 바람이 불어요 "
                
                let icon = json["weather"][0]["icon"].stringValue
                let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
                self.weatherImageView.kf.setImage(with: url)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    // 6) iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("승인상태 변경")
        checkUserLocationServicesAuthorization()
    }
    
    // 7) iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("승인상태 변경")
        checkUserLocationServicesAuthorization()
    }

}

