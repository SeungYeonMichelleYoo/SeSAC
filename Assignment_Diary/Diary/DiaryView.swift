//
//  DiaryView.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/21.
//

import UIKit
import SnapKit

class DiaryView: DiaryBaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        return view
    }()
    
    let imageButton: RedButton = {
        let btn = RedButton()
        return btn
    }()
    
    let titleTextField: BlackRadiusTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    let titleButton: RedButton = {
        let btn = RedButton()
        return btn
    }()
    
    let dateTextField: BlackRadiusTextField = {
        let view = BlackRadiusTextField ()
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    
    let dateButton: RedButton = {
        let btn = RedButton()
        return btn
    }()
    
    let contentTextView: UITextView = {
        let view = UITextView()
        return view
    }()
    
    let contentButton: RedButton = {
        let btn = RedButton()
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        
        [photoImageView, imageButton, titleTextField, titleButton, dateTextField, dateButton, contentTextView, contentButton].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        imageButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(photoImageView.snp.trailing).offset(-20)
            make.bottom.equalTo(photoImageView.snp.bottom).offset(-20)
        }
        
        titleTextField.snp.remakeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        titleButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(titleTextField.snp.trailing).offset(-20)
            make.bottom.equalTo(titleTextField.snp.bottom).offset(-20)
        }
        
        dateTextField.snp.remakeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        dateButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(dateTextField.snp.trailing).offset(-20)
            make.bottom.equalTo(dateTextField.snp.bottom).offset(-20)
        }
        
        contentTextView.snp.remakeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(contentTextView.snp.trailing).offset(-20)
            make.bottom.equalTo(contentTextView.snp.bottom).offset(-20)
        }
    }
}
