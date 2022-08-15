//
//  WeatherAPIManager.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/15.
//37.517829, 126.886270

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    
    //인스턴스 생성
    static let shared = WeatherAPIManager()
    
    //초기화되지 않도록 방지
    private init() { }
    //형태, 개수 지정 (struct, string, int 등)
    typealias completionHandler = (WeatherModel, String) -> Void
    
    func callRequest(lat: Double, lon: Double, completionHandler: @escaping completionHandler) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIKey.weather)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let humidity = json["main"]["humidity"].stringValue
                let temperature = json["main"]["temp"].doubleValue
                let wind = json["wind"]["speed"].stringValue
                let iconImage = json["weather"].arrayValue[0]["icon"].stringValue
                let location = json["name"].stringValue
                
                let format = DateFormatter()
                format.dateFormat = "MM월 dd일 HH시 mm분"
                let current_date_string = format.string(from: Date())
                let time = current_date_string
                
                let weatherData: WeatherModel = WeatherModel(time: time, location: location, temperature: temperature, humidity: humidity, wind: wind, latitude: lat, longitude: lon)
            
//                let imageURL = "http://openweathermap.org/img/wn/\(iconImage)@2x.png"
                
                completionHandler(weatherData, iconImage)
                
            case .failure(let error):
                print(error)
            }
        }
    }
   
}
