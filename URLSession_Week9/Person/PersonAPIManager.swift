//
//  PersonAPIManager.swift
//  URLSession_Week9
//
//  Created by SeungYeon Yoo on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    static func requestPerson(query: String, completion: @escaping (Person?, APIError?) -> Void ) {
        
//        let url =
//        URL(string: "https://api.themoviedb.org/3/search/person?api_key=1a2c6b44273f726ddf6c707c9d32a212&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "aa647781e526d18186b74e24132beb08"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
//        URLSession.request(endpoint: component.url!) { success, fail in
//            <#code#>
//        }
        print(component.url!)
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
                       
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
                    let result = try JSONDecoder().decode(Person.self, from: data) //데이터를 해당파일에 코딩해서 넣겠다. (decodable)
                    completion(result, nil)
                    print(result)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
