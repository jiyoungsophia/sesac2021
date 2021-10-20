//
//  LocationViewController.swift
//  SeSAC_04Week
//
//  Created by 양지영 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
//import CoreLocationUI iOS 15 locationBtn

/*
 1. 설정 유도
 2. 위경도 -> 주소 변환
 3.
 
 */

class LocationViewController: UIViewController {

    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // 1.c
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

                // 지역 설정
        let location = CLLocationCoordinate2D(latitude: 37.55321338602144, longitude: 126.97209451713331)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        // 핀 설정
        let annotation = MKPointAnnotation()
        annotation.title = "여기!"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        // 맵뷰에 어노테이션 삭제하고자 할때
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        // 2.
        locationManager.delegate = self
        
        
        
    }

}

extension LocationViewController: MKMapViewDelegate {
    // 맵 어노테이션 클릭 시 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("핀 클릭")
    }
}


// 3.
extension LocationViewController: CLLocationManagerDelegate {
    // 9. iOS 버전에 따른 분기 처리와  c
    func checkUserLocationServicesAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS14 미만
        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능(8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스 켜줘")
        }
        
    }
    
    
    // 8. 사용자 권한 상태 확인(UDF 사용자 정의 함수 not 프로토콜 내 메서드)
    // 사용자가 위치를 허용했는 지 안했는지 거부한건지 이런 권한을 확인(단 iOS 위치 서비스 가능한지 확인)
    // @unknown
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 디폴트 설정되어있음 옵션
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
            // 정확도 체크: 정확도 감소가 되어 있을 경우, 1시간 4번, 미리 알림, 배터리 오래 쓸 수 있음, 워치8
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
    
    
    
    // 4. 사용자가 위치 허용한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            // 새 핀 꽂기
            let annotation = MKPointAnnotation()
            annotation.title = "지금 여깃다"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // 10. 중요
            locationManager.startUpdatingLocation()
            
        } else {
            print("LOCATION CANNOT FIND")
        }
    }
    
    // 5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 6. iOS 14 미만: 앱이 위치 관리자를 생성, 승인 상태가 변경이 될 때 대리자에게 승인상태 알려줌
    // 권한이 변경 될 때 마다 감지해서 실행됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    // 7. iOS 14 이상: 앱이 위치 관리자를 생성, 승인 상태가 변경이 될 때 대리자에게 승인상태 알려줌
    // 권한이 변경 될 때 마다 감지해서 실행됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
}
