//
//  LottoAPIManager.swift
//  URLSession_Week9
//
//  Created by SeungYeon Yoo on 2022/08/30.
//

import Foundation

//shared - 단순한 요청일 때 사용. 커스텀 X(이미지 정해진 틀이 있어서). 응답은 클로저로 전달 받게 됨. 백그라운드 전송 못함.
//default configuration - shared 설정과 유사하지만, 커스텀이 가능(셀룰러(wifi/LTE) 연결 여부, 타임아웃 간격). 응답은 클로저, 딜리게이트 둘 다 가능.

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManager {
    
    static func requestLotto(drwNo: Int, completion: @escaping (Lotto?, APIError?) -> Void ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //            print(data)
            //            print(String(data: data!, encoding: .utf8))
            //            print(response)
            //            print(error)
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data) //데이터를 해당파일에 코딩해서 넣겠다. (decodable)
                    completion(result, nil)
                    print(result)
                    print(result.drwNoDate)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
        
        
    }
}
