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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

