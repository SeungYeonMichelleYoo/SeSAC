//
//  KakaoAPIManager.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/08.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (JSON) -> () ) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return } //한글 때문에 인코딩 처리
        let url = type.requestURL + query
       
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
                                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
