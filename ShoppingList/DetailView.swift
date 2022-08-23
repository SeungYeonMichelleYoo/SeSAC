//
//  DetailView.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/23.
//

import UIKit

class DetailView: BaseView {
    
    //MARK: - label
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        
        self.addSubview(self.titleLabel)
    }
    
    override func setConstraints() {
        
    
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(20)
            make.leadingMargin.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailingMargin.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        
        
    }

}
