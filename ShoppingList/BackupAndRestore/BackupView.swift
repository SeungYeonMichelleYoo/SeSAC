//
//  BackupView.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/25.
//
import UIKit
import SnapKit

class BackupView: BaseView {
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.tintColor = .white
        view.backgroundColor = .blue
        return view
    }()
    
    let returnButton: UIButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemPink
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
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(150)
        }
        
        returnButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(backupButton.snp.leading).offset(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(500)
        }
        
    }
}
