//
//  CardView.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/09.
//

import UIKit

class CardView: UIView {


    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds // 카드뷰와 동일하게 모서리 만들기 위한 코드
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
