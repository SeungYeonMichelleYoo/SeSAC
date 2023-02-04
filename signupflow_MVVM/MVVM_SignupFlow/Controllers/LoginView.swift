//
//  LoginView.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//
import UIKit
import SnapKit

class LoginView: BaseView {
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let txtfield = UITextField()
        txtfield.font = .systemFont(ofSize: 15)
        txtfield.backgroundColor = .lightGray
        return txtfield
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let txtfield = UITextField()
        txtfield.font = .systemFont(ofSize: 15)
        txtfield.backgroundColor = .lightGray
        return txtfield
    }()
    
    lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("로그인", for: .normal)
        view.titleLabel?.font =  UIFont(name: "Times New Roman", size: 18)
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var signupButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.titleLabel?.font =  UIFont(name: "Times New Roman", size: 18)
        view.backgroundColor = .purple
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton, signupButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.top)
            make.leading.equalTo(emailLabel.snp.trailing).offset(30)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.top)
            make.leading.equalTo(passwordLabel.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.top).offset(50)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.top).offset(50)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
