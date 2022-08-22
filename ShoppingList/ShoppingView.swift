//
//  ShoppingView.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/22.
//
import UIKit
import SnapKit

class ShoppingView: BaseView {
    
    //MARK: - tableView
    
    let listTableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    //MARK: - 테이블뷰 위에 subView(UIView) 삽입
    
    let subView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - subView 안의 요소(쇼핑 제목 라벨, 회색 uiview, 텍스트필드, 추가버튼)
    let shoppingtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "쇼핑"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let grayUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    let purchaseTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하실건가요?"
        return view
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("추가", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    //MARK: - tableview cell . stackview이용
    let checkImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "checkmark.square.fill")
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
        return btn
    }()
    
    //MARK: - stackview
    let tableviewcellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        
        //MARK: - tableview
        
        self.addSubview(listTableView)
        
        //MARK: - subview (테이블뷰 위에 삽입)
        self.listTableView.addSubview(self.subView)
        self.subView.addSubview(self.shoppingtitleLabel)
        self.subView.addSubview(self.grayUIView)
        self.grayUIView.addSubview(self.purchaseTextField)
        self.grayUIView.addSubview(self.addButton)
        
        //MARK: - stackview안 요소 등록
        [self.checkImage, self.listLabel, self.favoriteButton].forEach { tableviewcellStackView.addArrangedSubview($0) }
//        [listTableView, subView].forEach {
//            self.addSubview($0)
//        }
        
        //MARK: - tableview cell - stackview
        self.listTableView.addSubview(tableviewcellStackView)
    }
    
    override func setConstraints() {
        //MARK: - tableview 전체로 덮기
        listTableView.snp.makeConstraints { make in
            make.top.leadingMargin.trailingMargin.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: - subview 윗부분에 삽입
        subView.snp.makeConstraints { make in
            make.top.leadingMargin.trailingMargin.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(130)
        }
        
        //MARK: - 쇼핑 타이틀 라벨
        shoppingtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(20)
            make.leadingMargin.equalTo(subView.snp.leading).offset(20)
            make.trailingMargin.equalTo(subView.snp.trailing).offset(20)
            make.bottom.equalTo(subView.snp.bottom).offset(20)
        }
        
        //MARK: - 회색 뷰
        grayUIView.snp.makeConstraints { make in
            make.width.equalTo(shoppingtitleLabel)
            make.bottom.equalTo(subView.snp.bottom).offset(-20)
        }
        
        //MARK: - 회색 뷰 안에 텍스트필드, 추가버튼
        purchaseTextField.snp.makeConstraints { make in
            make.top.equalTo(grayUIView.snp.top).offset(8)
            make.leadingMargin.equalTo(grayUIView.snp.leading).offset(20)
            make.trailingMargin.equalTo(grayUIView.snp.leading).offset(8)
            make.bottom.equalTo(grayUIView.snp.bottom).offset(8)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(grayUIView.snp.trailing).offset(-8)
            make.centerY.equalTo(purchaseTextField)
        }
        
        //MARK: - stackview 안에 구성(테이블뷰 셀)
        
        tableviewcellStackView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(80)
        }
        
        checkImage.snp.makeConstraints { make in
            make.centerY.equalTo(tableviewcellStackView)
            make.leadingMargin.equalTo(tableviewcellStackView.leading).offset(20)
            make.trailingMargin.equalTo(tableviewcellStackView.trailing).offset(20)
        }
        
        listLabel.snp.makeConstraints { make in
            <#code#>
        }
        
    }

}
