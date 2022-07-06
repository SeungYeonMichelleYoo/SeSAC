//
//  SignUpViewController.swift
//  Movie
//
//  Created by SeungYeon Yoo on 2022/07/06.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailtxtField: UITextField!
    @IBOutlet weak var passwordtxtField: UITextField!
    @IBOutlet weak var nicknametxtField: UITextField!
    @IBOutlet weak var locationtxtField: UITextField!
    @IBOutlet weak var recommendtxtField: UITextField!
    @IBOutlet weak var signUpImg: UIButton!
    @IBOutlet weak var SwitchBtn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtxtField.textColor = .white
        emailtxtField.keyboardType = .emailAddress
        emailtxtField.backgroundColor = .darkGray
        emailtxtField.borderStyle = .roundedRect
        emailtxtField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        passwordtxtField.textColor = .white
        passwordtxtField.isSecureTextEntry = true
        passwordtxtField.backgroundColor = .darkGray
        passwordtxtField.borderStyle = .roundedRect
        passwordtxtField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        nicknametxtField.textColor = .white
        nicknametxtField.backgroundColor = .darkGray
        nicknametxtField.borderStyle = .roundedRect
        nicknametxtField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        locationtxtField.textColor = .white
        locationtxtField.backgroundColor = .darkGray
        locationtxtField.borderStyle = .roundedRect
        locationtxtField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        recommendtxtField.textColor = .white
        recommendtxtField.backgroundColor = .darkGray
        recommendtxtField.borderStyle = .roundedRect
        recommendtxtField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        signUpImg.setTitle("회원가입", for: .normal)
        signUpImg.setTitleColor(UIColor.black, for: .normal)
        signUpImg.backgroundColor = .white
        signUpImg.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        SwitchBtn.setOn(true, animated: true)
        SwitchBtn.onTintColor = .red
        SwitchBtn.thumbTintColor = .white
//        SwitchBtn.tintColor = .lightGray
        SwitchBtn.backgroundColor = .lightGray
        SwitchBtn.layer.cornerRadius = 16
        
//        let onColor  = UIColor.red
//        let offColor = UIColor.lightGray
//
//        let SwitchBtn = UISwitch(frame: CGRect.zero)
//        SwitchBtn.isOn = true
//
//        /*For on state*/
//        SwitchBtn.onTintColor = onColor
//
//        /*For off state*/
//        SwitchBtn.tintColor = offColor
//        SwitchBtn.layer.cornerRadius = SwitchBtn.frame.height / 2.0
//        SwitchBtn.backgroundColor = offColor
//        SwitchBtn.clipsToBounds = true
//
    }
    
    @IBAction func tapGestureClicked1(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
}
