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
    
    //MARK: - Stackview
    let verticalstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()

    
    //MARK: - 추가정보입력 및 스위치
    let additionalLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let onoffSwitch: UISwitch = {
        let view = UISwitch()
        view.onTintColor = .red
        view.isOn = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureUI() {
        [self.emailTextField, self.passwordTextField, self.nicknameTextField, self.locationTextField, self.recommendTextField, self.signupButton].forEach { verticalstackView.addArrangedSubview($0) }
        [jackflixLabel, verticalstackView, additionalLabel, onoffSwitch].forEach {
            self.addSubview($0)
        }

    }
    
    override func setConstraints() {
        jackflixLabel.snp.remakeConstraints { make in
            make.top.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        verticalstackView.snp.makeConstraints { make in
            make.top.equalTo(jackflixLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        additionalLabel.snp.makeConstraints { make in
            make.top.equalTo(verticalstackView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(38) //verticalstackView.snp.leading으로 하면 안 맞춰짐. 왜????
        }
        
        onoffSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(additionalLabel)
            make.trailing.equalTo(verticalstackView.snp.trailing)
        }
        
        
    }
    
}
