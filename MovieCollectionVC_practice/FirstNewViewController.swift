//
//  FirstNewViewController.swift
//  MovieCollectionVC_practice
//
//  Created by SeungYeon Yoo on 2022/07/21.
//

import UIKit

class FirstNewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "검색결과 화면"
        //네비게이션 왼쪽 바버튼아이템 생성
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkClicked))
    }
    @objc func xmarkClicked() {
        self.dismiss(animated: true)
    }

}
