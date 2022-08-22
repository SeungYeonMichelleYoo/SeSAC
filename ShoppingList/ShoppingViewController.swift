//
//  ShoppingViewController.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/22.
//
import UIKit
import SnapKit

class ShoppingViewController: BaseViewController {
  
    var mainView = ShoppingView()
    
    //viewDidLoad보다 먼저 호출된다
    override func loadView() { //super.loadView 호출 금지
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
