//
//  HomeTableViewCell.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var data: UserDiary = UserDiary()
    
    let diaryImg: DiaryImageView = {
        let img = DiaryImageView(frame: .zero)
        return img
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    private func layout() {
        
        self.contentView.addSubview(diaryImg)
        self.contentView.addSubview(title)
        
        diaryImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailingMargin.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leadingMargin.equalToSuperview()
            make.width.equalTo(150)
        }
    }
    
    func setData(data: UserDiary) {
        self.data = data
    }
    
}
