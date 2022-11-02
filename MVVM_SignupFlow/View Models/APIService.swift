//
//  APIService.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//
import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

class APIService {
    
    //회원가입
    func signup() {
        let api = SeSACAPI.signup(userName: "testMichelle2", email: "testMichelle2@testMichelle2.com", password: "12345678")
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response)
            print(response.response?.statusCode)
        }
    }
    
    //로그인
    func login() {
        let api = SeSACAPI.login(email: "testMichelle@testMichelle.com", password: "12345678")
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                
                switch response.result {
                case .success(let data):
                    print(data.token)
                    UserDefaults.standard.set(data.token, forKey: "token")
                    
                case .failure(_):
                    print(response.response?.statusCode)
                }
            }
    }
    
    //내 프로필 보기
    func profile() {
        let api = SeSACAPI.profile
        AF.request(api.url, method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { response in
                
                switch response.result {
                case .success(let data):
                    print(data)
                    
                case .failure(_):
                    print(response.response?.statusCode)
                }
            }
    }
}
