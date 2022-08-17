//
//  KakaoTalkViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/17.
//
import UIKit
import SnapKit

class KakaoTalkViewController: UIViewController {

    let xbutton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let gift: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "gift.png")
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    
    let fullscreen: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "fullscreen.png")
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    
    let setting: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "setting.png")
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        
        [xbutton, gift, fullscreen, setting].forEach {
            view.addSubview($0)
        }
        
        xbutton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
//            make.trailingMargin.equalTo(-20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        gift.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leadingMargin.equalTo(70)
            make.trailingMargin.equalTo(-130)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        fullscreen.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leadingMargin.equalTo(120)
            make.trailingMargin.equalTo(-75)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        setting.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leadingMargin.equalTo(170)
            make.trailingMargin.equalTo(-20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
}
