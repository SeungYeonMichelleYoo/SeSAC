//
//  LoginViewController.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/19.
//

import Foundation
import SnapKit

class LoginViewController: BaseViewController {
  
    var mainView = LoginView()
    
    //viewDidLoad보다 먼저 호출된다
    override func loadView() { //super.loadView 호출 금지
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
