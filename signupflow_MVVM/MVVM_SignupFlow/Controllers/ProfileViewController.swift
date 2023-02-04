//
//  ProfileViewController.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//

import UIKit

class ProfileViewController: BaseViewController {

    let api = APIService()
    
    var mainView = ProfileView()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api.profile()
    }

}
