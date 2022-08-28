//
//  SearchView.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/27.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    //MARK: - tableView
    
    let searchTableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [searchTableView].forEach {
            self.addSubview($0)
        }
    }
    override func setConstraints() {
        
        //MARK: - subview 윗부분에 삽입
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leadingMargin.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailingMargin.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
            make.height.equalTo(800)
        }
    
    }
    
}

