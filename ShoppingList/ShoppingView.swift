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
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let purchaseTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하실건가요?"
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("추가", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    //MARK: - tableview cell . stackview이용
//    let checkImage: UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(systemName: "checkmark.square.fill")
//        img.contentMode = .scaleAspectFit
//        return img
//    }()
//
//    let listLabel: UILabel = {
//        let label = UILabel()
//        label.text = "쇼핑"
//        label.textColor = UIColor.black
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        return label
//    }()
//
//    let favoriteButton: UIButton = {
//        let btn = UIButton()
//        btn.setImage(UIImage(systemName: "star"), for: .normal)
//        btn.setTitleColor(UIColor.black, for: .normal)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//        btn.contentMode = .scaleAspectFit
//        return btn
//    }()
    
////    MARK: - stackview
//    let tableviewcellStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
////        stackView.distribution = .fillEqually
//        stackView.spacing = 8.0
////        stackView.alignment = .fill
//        stackView.backgroundColor = .lightGray
//        return stackView
//    }()

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
        self.grayUIView.addSubview(self.addButton)
        self.grayUIView.addSubview(self.purchaseTextField)
        
//        //MARK: - stackview안 요소 등록
//        [self.checkImage, self.listLabel, self.favoriteButton].forEach { tableviewcellStackView.addArrangedSubview($0) }
        [listTableView, subView].forEach {
            self.addSubview($0)
        }

        //MARK: - tableview cell - stackview
//        self.listTableView.addSubview(self.tableviewcellStackView)
    }

    override func setConstraints() {
        //MARK: - tableview 전체로 덮기
        listTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: - 쇼핑 타이틀 라벨
        shoppingtitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(subView)
            make.top.equalTo(subView.snp.top).inset(8)
            make.bottom.equalTo(grayUIView.snp.top).offset(20)
        }
        
        //MARK: - 회색 뷰
        grayUIView.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(70)
            make.bottom.equalTo(subView.snp.bottom).inset(8)
            make.leadingMargin.equalTo(subView.snp.leading).inset(20)
            make.trailingMargin.equalTo(subView.snp.trailing).inset(20)
        }
        
        //MARK: - subview 윗부분에 삽입
        subView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leadingMargin.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailingMargin.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(150)
        }
        
        //MARK: - 회색 뷰 안에 텍스트필드, 추가버튼
        
        addButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(grayUIView.snp.trailing).inset(20)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.centerY.equalTo(purchaseTextField)
        }
        
        purchaseTextField.snp.makeConstraints { make in
            make.centerY.equalTo(grayUIView)
            make.top.equalTo(grayUIView.snp.top).inset(8)
            make.leadingMargin.equalTo(grayUIView.snp.leading).inset(20)
            make.trailingMargin.equalTo(addButton.snp.leading).offset(-20)
            make.bottom.equalTo(grayUIView.snp.bottom).inset(8)
        }
    
        
        
//        MARK: - stackview 안에 구성(테이블뷰 셀)

//        tableviewcellStackView.snp.makeConstraints { make in
//            make.top.equalTo(150)
//            make.height.equalTo(80)
//            make.leadingMargin.equalTo(subView.snp.leading).inset(8)
//            make.trailingMargin.equalTo(subView.snp.trailing).inset(8)
//        }
        
//        checkImage.snp.makeConstraints { make in
//            make.width.equalTo(40)
//            make.height.equalTo(40)
//            make.centerY.equalTo(tableviewcellStackView)
//        }
//
//        listLabel.snp.makeConstraints { make in
//            make.leadingMargin.equalTo(checkImage.snp.trailing).offset(20)
//            make.trailingMargin.equalTo(favoriteButton.snp.leadingMargin).offset(20)
//        }
//
//        favoriteButton.snp.makeConstraints { make in
//            make.width.equalTo(40)
//            make.height.equalTo(40)
//            make.centerY.equalTo(tableviewcellStackView)
//            make.trailingMargin.equalTo(tableviewcellStackView.snp.trailing).inset(20)
//        }
        
    }

}
