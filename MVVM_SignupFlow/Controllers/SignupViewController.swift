//
//  SignupViewController.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//

import UIKit

class SignupViewController: BaseViewController {
    
    let api = APIService()
    
    var mainView = SignupView()

    override func loadView() {
        self.view = mainView 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api.signup()
        mainView.okButton.addTarget(self, action: #selector(okbuttonClicked), for: .touchUpInside)
    }
    @objc func okbuttonClicked() {
        let vc = ProfileViewController()
        transition(vc, transitionStyle: .push)
    }


}
