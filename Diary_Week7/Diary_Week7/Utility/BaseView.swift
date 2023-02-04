//
//  BaseView.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    
    //코드베이스일 때 쓰는 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()        
    }
    
    //스토리보드일 때 쓰는 구문. xib로 뷰를 만들 때. 프로토콜 기반으로 구현이 되어있기 때문에 코드베이스라도 이걸 구현해야됨.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //런타임오류
    }
    
    func configureUI() { }
    
    func setConstraints() { }
}

//required initializer
protocol example {
    init(name: String)
}

class Mobile {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        super.init(name: "모바일")
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
}

let a = Apple(wwdc: "애플")
