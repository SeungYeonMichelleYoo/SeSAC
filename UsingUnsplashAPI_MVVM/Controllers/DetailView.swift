//
//  DetailView.swift
//  UsingUnsplashAPI_MVVM
//
//  Created by SeungYeon Yoo on 2022/11/05.
//
import UIKit
import SnapKit

class DetailView: BaseView {
    lazy var detailImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.addSubview(detailImg)
    }
    override func setConstraints() {
        detailImg.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(500)
        }
    }
}
