//
//  ViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol {
    static var identifier: String = "ViewController"
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    var backgroundColor: UIColor {
        get {
            return.blue
        }
    }
    
    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치"
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
//    let helper = UserDefaultsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultsHelper.standard.nickname = "고래밥" // UserDefaultsHelper의 userDefaults의 newValue안에 들어가는걸 이렇게 단축시킬 수 있음
        title = UserDefaultsHelper.standard.nickname // UserDefaultsHelper의 userDefaults의 get 가져옴
        UserDefaultsHelper.standard.age = 80
        print(UserDefaultsHelper.standard.age)
    }


}

