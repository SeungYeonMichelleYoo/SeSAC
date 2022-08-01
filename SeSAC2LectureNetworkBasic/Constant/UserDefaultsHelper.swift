//
//  UserDefaultsHelper.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/08/01.
//

import Foundation
import UIKit

class UserDefaultsHelper {
    
    private init() { }
    //인스턴스가 원래 여러군데에 썼었는데, 이걸 아예 지금처럼 class 에 넣어버림. static 타입형태로 넣은거.
    static let standard = UserDefaultsHelper()
    //singleton pattern: 자기자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set { //연산프로퍼티 default로 사용하는 값: newValue
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue) //int, bool 의 데이터타입을 가진 userDefaults는 nil 또는 0 default값을 가지고 있음, 따라서 ?? 처리할 필요 없다.
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
