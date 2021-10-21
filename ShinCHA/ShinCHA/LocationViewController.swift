//
//  LocationViewController.swift
//  ShinCHA
//
//  Created by 신상원 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

class LocationViewController: UIViewController {
    
    let theater = mapAnnotations
    var boolButton: Array<Bool> = [false, false, false]
    let refButton: Array<String> = ["롯데시네마", "CGV", "메가박스"]

    // 1)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        
        // 3)
        mapView.delegate = self
        locationManager.delegate = self
        
        //초기에 모든 핀들이 화면에 출력될 수 있도록 설정!
        for info in theater {
            let latitude = info.latitude
            let longtitude = info.longitude
            
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            //let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            //let region = MKCoordinateRegion(center: location, span: span)
            
            let annotation = MKPointAnnotation()
            annotation.title = info.location
            annotation.coordinate = location
            annotation.subtitle = info.type //annotation 클릭해야 나오는거 확인함 -> 이걸 tag 처럼 사용할 계획
            mapView.addAnnotation(annotation)
        }
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    //right button 눌렀을 때
    @objc
    func filterButtonClicked() {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func filterTheater(_ index: Int) {
        //전체보기 누른경우 -> 전체 화면 다 추가
        if index == 3 {
            mapView.removeAnnotations(mapView.annotations)
            for info in theater {
                let latitude = info.latitude
                let longtitude = info.longitude
                let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)

                let annotation = MKPointAnnotation()
                annotation.title = info.location
                annotation.coordinate = location
                annotation.subtitle = info.type //annotation 클릭해야 나오는거 확인함 -> 이걸 tag 처럼 사용할 계획
                mapView.addAnnotation(annotation)
            }
        }
        
        else {
            mapView.removeAnnotations(mapView.annotations)
            for info in theater {
                if info.type == refButton[index] {
                    let latitude = info.latitude
                    let longtitude = info.longitude
                    let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)

                    let annotation = MKPointAnnotation()
                    annotation.title = info.location
                    annotation.coordinate = location
                    annotation.subtitle = info.type
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    //Alert 구현
    func showAlertController(style: UIAlertController.Style) {
        
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Filter", message: "영화관을 선택하세요", preferredStyle: style)
        
        let lotteAction: UIAlertAction
    
        lotteAction = UIAlertAction(title: "LOTTE", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in self.filterTheater(0)
        })
        
        let cgvAction: UIAlertAction
        cgvAction = UIAlertAction(title: "CGV", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in self.filterTheater(1)
        })
        
        let megaAction: UIAlertAction
        megaAction = UIAlertAction(title: "MEGA", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in self.filterTheater(2)
        })
        
        let allAction: UIAlertAction
        allAction = UIAlertAction(title: "ALL", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in self.filterTheater(3)
        })

        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        // action을 추가해줘야 실행된다.
        // 액션 순서에 상관없이 어떻게 넣어주더라도 위치는 UIAlertController가 알아서 지정해준다
        alertController.addAction(lotteAction)
        alertController.addAction(megaAction)
        alertController.addAction(cgvAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        
        // 모달로 올려줌 -> completion은 모달이 올라오는 애니메이션이 끝나고 직후에 호출될 블럭
        self.present(alertController, animated: true, completion: { print("Alert controller shown") })
        
    }
    @IBOutlet weak var mapView: MKMapView! //extension 잊지말자!
    
}

// 2)
extension LocationViewController: CLLocationManagerDelegate {
    
    //9. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
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
                        print("잘 열렸다. \(success)")
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
                        print("잘 열렸다. \(success)")
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
        
        // 사용자가 앱 내에서 위치 허용을 해줬으니까 현재 위치를 지도의 중심으로 설정한다.
        if let coordinate = locations.last?.coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = "나 여기"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            //10. 중요!!
            locationManager.stopUpdatingLocation()
            
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
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "눈물의 스터디 현장"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
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

extension LocationViewController: MKMapViewDelegate {
    
}

