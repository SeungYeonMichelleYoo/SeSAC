//
//  BackupView.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/24.
//

import UIKit
import SnapKit

class BackupView: BaseView {
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.tintColor = Constants.BaseColor.text
        view.backgroundColor = Constants.BaseColor.point
        view.layer.cornerRadius = 25
        return view
    }()
    
    let returnButton: UIButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.backgroundColor = .green
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.rowHeight = 100
        return view
    }()
    
    
    // MARK: - Methods
    override func configureUI() {
        [backupButton, returnButton, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        backupButton.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        returnButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(500)
        }
        
    }
}
