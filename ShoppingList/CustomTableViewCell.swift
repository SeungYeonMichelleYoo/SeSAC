//
//  CustomTableViewCell.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let cellId = "CustomCell"
    
    let checkImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "checkmark.square.fill")
        img.contentMode = .scaleAspectFit
        return img
    }()

    let listLabel: UILabel = {
        let label = UILabel()
        label.text = "쇼핑"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    let favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.contentMode = .scaleAspectFit
        return btn
    }()
    
    //    MARK: - stackview
        let tableviewcellStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
    //        stackView.distribution = .fillEqually
            stackView.spacing = 8.0
    //        stackView.alignment = .fill
            stackView.backgroundColor = .lightGray
            return stackView
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        self.addSubview(tableviewcellStackView)
        [self.checkImage, self.listLabel, self.favoriteButton].forEach { tableviewcellStackView.addArrangedSubview($0) }

                
        checkImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalTo(tableviewcellStackView)
        }

        listLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(checkImage.snp.trailing).offset(20)
            make.trailingMargin.equalTo(favoriteButton.snp.leadingMargin).offset(20)
        }

        favoriteButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalTo(tableviewcellStackView)
            make.trailingMargin.equalTo(tableviewcellStackView.snp.trailing).inset(20)
        }
        
        tableviewcellStackView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.height.equalTo(70)
            make.leadingMargin.equalTo(self.safeAreaLayoutGuide)
            make.trailingMargin.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
