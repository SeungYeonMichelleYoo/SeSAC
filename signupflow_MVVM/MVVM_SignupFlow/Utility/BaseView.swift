//
//  BaseView.swift
//  MVVM_SignupFlow
//
//  Created by SeungYeon Yoo on 2022/11/02.
//
import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
    }
    
    func setConstraints() {}
}
