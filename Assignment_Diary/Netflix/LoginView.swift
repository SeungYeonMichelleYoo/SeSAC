//
//  LoginView.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/19.
//

import UIKit
import SnapKit

class LoginView: BaseView {
    
    //MARK: - JACKFLIX 라벨 1개
    
    let jackflixLabel: UILabel = {
        let label = UILabel()
        label.text = "JACKFLIX"
        label.textColor = UIColor.red
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    //MARK: - Stackview
    
    let verticalstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    //MARK: - StackView에 들어갈 항목들
    let emailTextField: UserTextField = {
        let textField = UserTextField()
        textField.placeholder = "이메일 주소 또는 전화번호"
        return textField
    }()
    
    let passwordTextField: UserTextField = {
        let textField = UserTextField()
        textField.placeholder = "비밀번호"
        return textField
    }()
    
    let nicknameTextField: UserTextField = {
        let textField = UserTextField()
        textField.placeholder = "닉네임"
        return textField
    }()
    
    let locationTextField: UserTextField = {
        let textField = UserTextField()
        textField.placeholder = "위치"
        return textField
    }()
    
    let recommendTextField: UserTextField = {
        let textField = UserTextField()
        textField.placeholder = "추천코드 입력"
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    //MARK: - 추가정보입력 및 스위치
    let additionalLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        
        [jackflixLabel, verticalstackView, additionalLabel].forEach {
            self.addSubview($0)
        }
        
        let verticalstackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nicknameTextField, locationTextField, recommendTextField, signupButton])
        self.addSubview(verticalstackView)
        
    }
    
    override func setConstraints() {
        jackflixLabel.snp.remakeConstraints { make in
            make.top.equalTo(80)
            make.leadingMargin.equalTo(120)
        }
        
        verticalstackView.snp.makeConstraints { make in
            make.top.equalTo(jackflixLabel.snp.bottom).offset(50)
            make.leadingMargin.equalTo(50)
            make.trailingMargin.equalTo(50)
            make.width.equalTo(50)
        }
        
    }
    
}
