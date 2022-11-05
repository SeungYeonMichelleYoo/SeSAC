//
//  PhotoListView.swift
//  UsingUnsplashAPI_MVVM
//
//  Created by SeungYeon Yoo on 2022/11/05.
//

import UIKit
import SnapKit

class PhotoListView: BaseView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.borderColor = UIColor.blue.cgColor
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.largeContentImage?.withTintColor(.blue) // 왼쪽 돋보기 모양 커스텀
        searchBar.searchTextField.borderStyle = .none // 기본으로 있는 회색배경 없애줌
        searchBar.searchTextField.leftView?.tintColor = .blue //???
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 4
        
        let spacing : CGFloat = 4
        let myWidth = UIScreen.main.bounds.width * 0.27
        
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: myWidth, height: myWidth)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [searchBar, collectionView].forEach {
            self.addSubview($0)
        }
    }
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}

