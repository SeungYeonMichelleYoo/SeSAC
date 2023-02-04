//
//  LoginViewController.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//

import UIKit

class LoginViewController: BaseViewController {
    
    let api = APIService()
    
    var loginViewModel = LoginViewModel()
    
    var mainView = LoginView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.login()
        
        mainView.loginButton.addTarget(self, action: #selector(loginbuttonClicked), for: .touchUpInside)
        
    }
    @objc func loginbuttonClicked() {
        
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let email = mainView.emailTextField.text, !email.isEmpty else { return }
        guard let password = mainView.passwordTextField.text, !password.isEmpty else { return }
        
        if loginViewModel.isValidEmail(id: email){
        }
        else {// 이메일 형식 오류
            showAlertMessage(title: "이메일 형식을 확인해주세요.", button: "확인")
        }
        
        if loginViewModel.isValidPassword(pwd: password){
        }
        else{
            showAlertMessage(title: "비밀번호 형식을 확인해주세요.", button: "확인")
        } // 비밀번호 형식 오류
        
        if loginViewModel.isValidEmail(id: email) && loginViewModel.isValidPassword(pwd: password) {
            let loginSuccess: Bool = loginViewModel.loginCheck(id: email, pwd: password)
            if loginSuccess {
                print("로그인 성공")
            }
            else {
                showAlertMessage(title: "로그인 실패. 아이디나 비밀번호가 다릅니다.", button: "확인")
            }
        }
        
        let vc = ProfileViewController()
        transition(vc, transitionStyle: .push)
    }
    
    
    
}
