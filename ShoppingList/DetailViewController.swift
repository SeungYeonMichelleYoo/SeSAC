//
//  DetailViewController.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/23.
//

import UIKit
import SnapKit
import RealmSwift //Realm 1.

class DetailViewController: BaseViewController {

    var mainView = DetailView()
    
    //1)값 전달 공간 만들기
    var titlelabel: String? = " "
    
    let localRealm = try! Realm() //Realm2. Realm 테이블 경로 가져오기
    
    //viewDidLoad보다 먼저 호출된다
    override func loadView() { //super.loadView 호출 금지
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
        mainView.titleLabel.text = titlelabel
    }
    
    
    override func configure() {
        
    }
    
}
