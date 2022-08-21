//
//  CircleImageView.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/19.
//

import UIKit

class CircleImageView: UIImageView {
    
    required init() {
        super.init(frame: .zero)
        uiImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func uiImageView() {
//        layer.cornerRadius = 25
        clipsToBounds = true
        
    }
}
