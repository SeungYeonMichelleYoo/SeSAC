//
//  Netflix_Main.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/19.
//

import UIKit
import SnapKit

class NetflixView: BaseView {
    
    //MARK: - 상단 버튼 4개
    let logoButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("N", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return btn
    }()
    
    let tvButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("TV 프로그램", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    let movieButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("영화", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    let myButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("내가 찜한 콘텐츠", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    //MARK: -  중앙 버튼 3개
    
    let checkImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "check.png")
        return img
    }()
    
    let checkInfoButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("내가 찜한 콘텐츠", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    let playImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "play_normal.png")
        return img
    }()
    
    let infoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "info.png")
        return img
    }()
    
    let infodetailButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("정보", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    //MARK: - 미리보기 라벨 1개
    
    let previewLabel: UILabel = {
        let label = UILabel()
        label.text = "미리보기"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: - 하단 동그라미 이미지 3개
    
    let firstImageView: CircleImageView = {
        let view = CircleImageView(frame: .zero)
        view.image = UIImage(named: "겨울왕국2.png")
        return view
    }()
    
    let secondImageView: CircleImageView = {
        let view = CircleImageView(frame: .zero)
        view.image = UIImage.init(named: "7번방의선물.png")
        return view
    }()
    
    let thirdImageView: CircleImageView = {
        let view = CircleImageView()
        view.image = UIImage.init(named: "아바타.png")
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        
        [logoButton, tvButton, movieButton, myButton, checkImage, checkInfoButton, playImage, infoImage, infodetailButton, previewLabel, firstImageView, secondImageView, thirdImageView ].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        //MARK: - 상단 버튼 4개
        logoButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leadingMargin.equalTo(8)
        }
        
        tvButton.snp.remakeConstraints { make in
            make.top.equalTo(20)
            make.leadingMargin.equalTo(logoButton.snp.leading).offset(60)
        }
        
        movieButton.snp.remakeConstraints { make in
            make.top.equalTo(20)
            make.leadingMargin.equalTo(tvButton.snp.leading).offset(8)
        }
        
        myButton.snp.remakeConstraints { make in
            make.top.equalTo(20)
            make.leadingMargin.equalTo(movieButton.snp.leading).offset(8)
        }
        
        //MARK: -  중앙 버튼 3개
        checkImage.snp.remakeConstraints { make in
            make.top.equalTo(150)
            make.leadingMargin.equalTo(40)
        }
        
        checkInfoButton.snp.remakeConstraints { make in
            make.top.equalTo(checkImage.snp.bottom).offset(4)
            make.leadingMargin.equalTo(40)
        }
        
        playImage.snp.remakeConstraints { make in
            make.top.equalTo(150)
            make.leadingMargin.equalTo(checkInfoButton.snp.trailing).offset(30)
        }
        
        infoImage.snp.remakeConstraints { make in
            make.top.equalTo(150)
            make.leadingMargin.equalTo(playImage.snp.trailing).offset(30)
        }
        
        infodetailButton.snp.remakeConstraints { make in
            make.top.equalTo(infoImage.snp.bottom).offset(4)
            make.leadingMargin.equalTo(playImage.snp.trailing).offset(30)
        }
        
        //MARK: - 미리보기 라벨 1개
        previewLabel.snp.remakeConstraints { make in
            make.top.equalTo(190)
            make.leadingMargin.equalTo(4)
        }
        
        //MARK: - 하단 동그라미 이미지 3개
        firstImageView.snp.remakeConstraints { make in
            make.leadingMargin.equalTo(4)
            make.bottomMargin.equalTo(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
            firstImageView.layer.cornerRadius = 50
    
        }
        
    }
    
}
