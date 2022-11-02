//
//  ProfileView.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//

import UIKit
import SnapKit

class ProfileView: BaseView {
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let txtfield = UITextField()
        txtfield.font = .systemFont(ofSize: 15)
        txtfield.backgroundColor = .yellow
        return txtfield
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let txtfield = UITextField()
        txtfield.font = .systemFont(ofSize: 15)
        txtfield.backgroundColor = .yellow
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
        txtfield.backgroundColor = .yellow
        return txtfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [userNameLabel, usernameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.top)
            make.leading.equalTo(userNameLabel.snp.trailing).offset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.top)
            make.leading.equalTo(emailLabel.snp.trailing).offset(20)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.top)
            make.leading.equalTo(passwordLabel.snp.trailing).offset(20)
        }
    }
    
}
