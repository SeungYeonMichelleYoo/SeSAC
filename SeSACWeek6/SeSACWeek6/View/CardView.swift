//
//  CardView.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/09.
//

import UIKit
/*
 Xml Interface Builder
 1. UIView Custom class
 2. File's owner -> 자유도 , 확장성 더 높다
 
 */

/*
 View:
 -인터페이스 빌더 UI초기화 구문: required init?
   - 프로토콜 초기화 구문: required -> 초기화 구문이 프로토콜로 명세되어 있음
 -코드로만 UI 초기화 구문: override init
 */

protocol A {
    func example()
    init()
}

class CardView: UIView {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds // 카드뷰와 동일하게 모서리 만들기 위한 코드
        view.backgroundColor = .lightGray
        self.addSubview(view)
        
        //카드뷰를 인터페이스 빌더 기반으로 만들고, 레이아웃도 설정했는데 false가 아닌 true로 나온다...
        //위에서 let view~as!View 가 코드 베이스 형태로 가져오는 형태라서. (코드를 통해서 추가한 영역이라서)
        //true. 오토레이아웃 적용이되는 관점보다 오토리사이징이 내부적으로 constraints 처리가 됨.
        print(view.translatesAutoresizingMaskIntoConstraints)
    }
    
}
