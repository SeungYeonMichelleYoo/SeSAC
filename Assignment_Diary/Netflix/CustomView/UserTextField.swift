//
//  UserTextField.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/21.
//

import UIKit

class UserTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingTextField() {
        backgroundColor = .darkGray
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        font = .boldSystemFont(ofSize: 16)
    }
}
