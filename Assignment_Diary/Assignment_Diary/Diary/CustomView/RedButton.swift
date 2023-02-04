//
//  RedButton.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/21.
//

import UIKit

class RedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        backgroundColor = .red
    }
    
}
