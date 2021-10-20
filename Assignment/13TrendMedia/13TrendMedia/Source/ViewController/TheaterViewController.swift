//
//  TheaterViewController.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation

class TheaterViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var theaterList = TheaterLocationInfo()
    
    var annotationList = [MKPointAnnotation]()
    var regionLat: Double = 0
    var regionLong: Double = 0
    var count: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavUI()
        setLocation()
        
    }
    
    func setNavUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    
    @objc
    func filterButtonClicked() {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: "메가박스", style: .default, handler: { action in self.showTheater("메가박스") })
        let lotte = UIAlertAction(title: "롯데시네마", style: .default, handler: { action in self.showTheater("롯데시네마")})
        let cgv = UIAlertAction(title: "CGV", style: .default, handler: {action in self.showTheater("CGV")})
        let total = UIAlertAction(title: "전체보기", style: .default, handler: { action in
            self.showTheater("전체")
        })
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megabox)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(total)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)

    }

    // 기본 중심 위치 설정
    func setLocation() {
        annotationList.removeAll()
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        let location = CLLocationCoordinate2D(latitude: 37.566651568191766, longitude: 126.97770011905223)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        // 핀 설정
        let annotation = MKPointAnnotation()
        annotation.title = "서울시청"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        locationManager.delegate = self
    }
    
    func showTheater(_ theaterType: String) {
    
        annotationList.removeAll()
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        regionLat = 0
        regionLong = 0
        count = 0
        
        for i in 0..<theaterList.mapAnnotations.count {
            let theater = theaterList.mapAnnotations[i]
            
            if theaterType == theater.type{
                makeAnnotation(theater)
            } else if theaterType == "전체" {
                makeAnnotation(theater)
            }
        }
        mapView.addAnnotations(annotationList)
        
        // 전체는 잘 안보임,, 어떠케 해야댈지 모르겟슴,,
        let newLocation = CLLocationCoordinate2D(latitude: (regionLat / count), longitude: (regionLong / count))
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: newLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func makeAnnotation(_ theater : TheaterLocation) {
        let latitude = theater.latitude
        let longitude = theater.longitude
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.title = theater.location
        annotation.coordinate = location
        annotationList.append(annotation)
        
        regionLat += latitude
        regionLong += longitude
        count += 1
    }
}

extension TheaterViewController: CLLocationManagerDelegate {
    // 위치 허용했을 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위치"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
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
            print("DENIED. GO TO SETTING")
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
