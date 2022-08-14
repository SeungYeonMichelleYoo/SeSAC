//
//  MapViewController.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/13.
//

import UIKit
import MapKit
//1.임포트

//위치 권한 설정
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    
    //2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    let theaterData = TheaterList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3. 프로토콜 연결
        locationManager.delegate = self
        mapView.delegate = self
        
        
//        //지도 중심 잡기: 애플맵 활용해 좌표 복사
//        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
//        setRegion(center: center)
    }
    
    //MARK: - 위치 권한 허용 팝업
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showRequestLocationServiceAlert()
    }
    
    //MARK: - 영화관 목록 액션시트
    //제목, 메세지 없이
    func setActionSheet() {
        let actionSheetController
        = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: "메가박스", style: .default, handler: {  _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.getTheaterAnnotations(theaterName: "메가박스")
        })
        let lotte = UIAlertAction(title: "롯데시네마", style: .default, handler: {  _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.getTheaterAnnotations(theaterName: "롯데시네마")
        })
        let cgv = UIAlertAction(title: "CGV", style: .default, handler: {  _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.getTheaterAnnotations(theaterName: "CGV")
        })
        let showall = UIAlertAction(title: "전체보기", style: .default, handler: {  _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.getTheaterAnnotations(theaterName: "")
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheetController.addAction(megabox)
        actionSheetController.addAction(lotte)
        actionSheetController.addAction(cgv)
        actionSheetController.addAction(showall)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    //MARK: - 지도 중심, 범위 설정
    func setRegion(center: CLLocationCoordinate2D) {
        
        //지도 중심 기반으로 보여질 범위
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
        
    }
    
    //MARK: - 영화관 핀 여러개 찍기- 오늘의교훈: region과 annotation은 항상 함께한다.ㅋㅋ
    
    func getTheaterAnnotations(theaterName: String) {
        
        for theater in theaterData.mapAnnotations {
            if (theaterName == "" || theater.type == theaterName) {
                let coord = CLLocationCoordinate2DMake(theater.latitude, theater.longitude)
                setRegion(center: coord)
                setAnnotation(center: coord, brand: theater.type, location: theater.location)
            }
        }
    }
    
    
    //MARK: - 맵뷰내 pin 설정
    func setAnnotation(center: CLLocationCoordinate2D, brand: String, location: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = brand
        
        mapView.addAnnotation(annotation)
    }
    
    
    @IBAction func currentLocationClicked(_ sender: UIButton) {
        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    @IBAction func seSacCampusClicked(_ sender: UIButton) {
        mapView.showsUserLocation = false
        mapView.userTrackingMode = .none
        mapView.setRegion(MKCoordinateRegion(center: defaultCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.11)), animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = defaultCoordinate
        annotation.title = "이곳은 청년취업사관학교입니다."
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func actionSheetClicked(_ sender: UIButton) {
        setActionSheet()
    }
    
}
//MARK: - 위치 관련된 User Defined 메서드
extension MapViewController {
    //7. iOS버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    //위치 서비스가 켜져 있다면 권한을 요청하고, 꺼져있다면 커스텀 얼럿으로 상황 알려주기
    func checkUserDeviceLocationsServiceAuthorization() {
        //위치에 대한 권한 종류
        //CLAuthorizationStatus
        //-denied: 허용 안함/ 설정에서 추후에 거부/ 위치 서비스 중지/ 비행기 모드
        //-restricted: 앱 권한 자체 없는 경우/ 자녀 보호 기능 같은걸로 아예 제한
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //iOS 위치 서비스 활성화 여부 체크: locationServiceEnabled()
        if CLLocationManager.locationServicesEnabled() {
            //위치 서비스가 활성화 되어있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함.
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }
    
    //8. 사용자의 위치권한 상태 확인
    //사용자가 위치를 허용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인(단, 사전에 iOS위치 서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")

            let region = MKCoordinateRegion(center: defaultCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = defaultCoordinate
            annotation.title = "이곳은 청년취업사관학교입니다."

            //지도에 핀 추가
            mapView.addAnnotation(annotation)
            
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            //사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
            
        default: print("DEFAULT")
        }
    }
    
    //MARK: - 위치 권한 허용 팝업
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            //설정까지 이동하거나 설정 세부화면까지 이동하거나
            //한번도 설정앱에 들어가지 않았거나, 막 다운 받은 앱이거나
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default, handler: { _ in
            self.setActionSheet()
        })
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    //MARK: - 현재위치
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            if let coordinate = locations.last?.coordinate {
                setRegion(center: coordinate)
            }
            locationManager.stopUpdatingLocation()
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkUserDeviceLocationsServiceAuthorization()
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error")
        }
}

