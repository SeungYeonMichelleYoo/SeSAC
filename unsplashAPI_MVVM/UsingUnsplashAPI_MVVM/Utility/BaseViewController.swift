//
//  BaseViewController.swift
//  UsingUnsplashAPI_MVVM
//
//  Created by SeungYeon Yoo on 2022/11/05.
//
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white
    }
    
    
    func configure() {}
    
}

