//
//  CodeSnapViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/17.
//

import UIKit
import SnapKit

class CodeSnapViewController: UIViewController {
    //뷰 객체를 클로저 형태로 반환하는 스타일
    let photoImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.backgroundColor = .lightGray
            return view
        }()
        
        let titleTextField: UITextField = {
            let view = UITextField()
            view.borderStyle = .none
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            view.placeholder = "제목을 입력해주세요"
            view.textAlignment = .center
            view.font = .boldSystemFont(ofSize: 15)
            return view
        }()
    
    let dateTextField: UITextField = {
            let view = UITextField()
            view.borderStyle = .none
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            view.placeholder = "날짜를 입력해주세요"
            view.textAlignment = .center
            view.font = .boldSystemFont(ofSize: 15)
            return view
        }()
        
        let contentTextView: UITextView = {
            let view = UITextView()
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function)
        configureUI()
    }
    
    func configureUI() {
        
        [photoImageView, titleTextField, dateTextField, contentTextView].forEach {
            view.addSubview($0)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.remakeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.remakeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.remakeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        
    }

    

}
