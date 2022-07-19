//
//  UITextField+Extension.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/19.
//

import UIKit

extension UITextField {
    
    func borderColor() {
        self.layer.borderColor = UIColor.black.cgColor //IBOutlet연결하지 않고 쓸 수 있는 방법 = self
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
    }
}

