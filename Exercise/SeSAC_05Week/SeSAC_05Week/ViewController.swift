//
//  ViewController.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/25.
//

import UIKit
import Kingfisher
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        getCurrentWeather()
        setUI()
    }

    
    func getCurrentWeather() {
        
        WeatherAPIManager.shared.getCurrentWeather { (code, json) in
            switch code {
            case 200:
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.temperatureLabel.text = "지금은 \(Int(currentTemp))°C에요"
                
                let currentHumidity = json["main"]["humidity"].intValue
                self.humidityLabel.text = "\(currentHumidity)% 만큼 습해요"
                
                let currentWind = json["wind"]["speed"]
                self.windLabel.text = "\(currentWind)m/s의 바람이 불어요"
                
                let currentIcon = json["weather"][0]["icon"].stringValue
                let url = URL(string: "https://openweathermap.org/img/wn/\(currentIcon)@2x.png")
                self.weatherImageView.kf.setImage(with: url)
            
            case 400:
                print(json)
            default:
                print("오류")
            
            }
        }
    }
    
    func setUI() {
        let date = Date()
        let format = DateFormatter()    // 인스턴스화
        format.dateFormat = "MM월 dd일 HH시 mm분"
        dateLabel.text = "\(format.string(from: date))"

    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    // 위치 허용했을 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
//            let annotation = MKPointAnnotation()
//            annotation.title = "마포구"
//            annotation.coordinate = coordinate
//            mapView.addAnnotation(annotation)
//
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            mapView.setRegion(region, animated: true)
            
            locationManager.startUpdatingLocation()
            
        } else {
           print("ERROR didUpdateLocations")
        }
    }
    
    // 14 미만 위치 관리자 생성
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationSeriveAuthorization()
    }
    
    // 14 이상 위치 관리자 생성
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationSeriveAuthorization()
    }
    
    // iOS 위치 서비스 여부 확인
    func checkLocationSeriveAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치서비스를 켜주세요")
        }
        
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작 -> didUpdateLocation 실행
        case .restricted, .denied:
            showAlert(title: "설정", message: "설정에서 권한을 허용해주세요", okTitle: "설정으로 이동") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url) { success in
                        print("잘열림 \(success)")
                    }
                }
            }
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작
        case .authorizedAlways:
            print("ALWAYS")
        @unknown default:
            print("DEFAULT")
        }
        
        
        if #available(iOS 14.0, *) {
            // 정확도 체크
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("Reduced")
            @unknown default:
                print("DEFAULT")
            }
        }
    }
   
}
