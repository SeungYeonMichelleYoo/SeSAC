//
//  WeatherViewController.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/14.
//

import UIKit
import CoreLocation
import Kingfisher
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
        
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var WindLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var weatherData: WeatherModel!
    var imageURL: String = ""
    
    // CLLocationManager클래스의 인스턴스 locationManager를 생성
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self

        // 포그라운드일 때 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()

        // 배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // 위치 업데이트
        locationManager.startUpdatingLocation()

        // 위,경도 가져오기
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude

    }
    
    override func viewDidAppear(_ animated: Bool) {
        showRequestLocationServiceAlert()
    }
    
    @IBAction func refreshBtnClicked(_ sender: UIButton) {
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        print(latitude ?? 0, longitude ?? 0)
        
        
        //위치 정보 한국어로 표시
        let geocoder: CLGeocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
        
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if error == nil, let marks = placeMarks {
                marks.forEach { (placeMark) in
                    self.locationLabel.text = "\(placeMark.locality!)"
                }
            }
        }
        
        
        WeatherAPIManager.shared.callRequest(lat: latitude ?? 0, lon: longitude ?? 0) { weather, image in
            self.weatherData = weather
            
            self.temperatureLabel.text = "지금은 \(self.weatherData.temperature - 273.15)도 입니다."
            self.humidityLabel.text = "\(self.weatherData.humidity)%만큼 습해요."
            self.WindLabel.text = "\(self.weatherData.wind)m/s만큼 바람이 불어요."
            //아이콘 이미지 표시
            let imageURL = URL(string: "http://openweathermap.org/img/wn/\(image)@2x.png")
            self.iconImageView.kf.setImage(with: imageURL)
        }
        
        //각 라벨에 표시
        let format = DateFormatter()
        format.dateFormat = "MM월 dd일 HH시 mm분"
        let current_date_string = format.string(from: Date())
        timeLabel.text = "\(current_date_string)"
    }
    
}

//위치 관련된 User Defined 메서드
extension WeatherViewController {

    //위치 7. iOS 버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    //위치 서비스가 켜져 있다면 권한을 요청하고, 꺼져있다면 커스텀 얼럿으로 상황 알려주기
    func checkUserDeviceLocationServiceAuthorization() {
        //위치에 대한 권한 종류 (CL : location, 카메라면 카메라~~)
        //CLAuthorizationStatus
        //- denied: 허용 안함/ 설정에서 추후에 거부/ 위치 서비스 중지/ 비행기 모드
        //- restricted: 앱 권한 자체 없는 경우/ 자녀 보호 기능 같은걸로 아예 제한
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

    //위치 8. 사용자의 위치권한 상태 확인
    //사용자가 위치를 허용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인(단, 사전에 iOS위치 서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")

            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            //plist가 when in use가 등록이 먼저 되어있어야만 이 request메서드를 쓸 수 있다.
//            locationManager.startUpdatingLocation() ->없어도 되지 않을까?
            //단점: 업데이트를 무제한으로 함(위치정보를)

        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            //사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")
        }
    }

    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in

          //설정까지 이동하거나 설정 세부화면까지 이동하거나
          //한번도 설정앱에 들어가지 않았거나, 막 다운 받은 앱이거나
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)

          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)

      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}


//프로토콜 선언
extension WeatherViewController: CLLocationManagerDelegate {

    //사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)

        //ex. 위도 경도 기반으로 날씨 정보를 조회
        //ex. 지도를 다시 세팅
        if let coordinate = locations.last?.coordinate {
            
//            setRegionAndAnnotation(center: coordinate)
        }
        //업데이트 된 location으로 mapView의 center를 변경해주는 코드

        //위치 업데이트 멈춰!
        locationManager.stopUpdatingLocation()
    }

    //위치 6. 사용자의 위치를 못 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }

    //위치9. 사용자의 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정해서 변경했거나, 혹은 notDetermined에서 허용을 했거나 등
    //허용했어서 위치를 가지고 오는 중에,  설정에서 거부하고 돌아온다면?
    //iOS 14 이상: 사용자의 권한 상태가 변경될 때, 위치 관리자 생성할 때 호출됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    //iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}

