//
//  BaseViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/19.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        
    }
    
    func configure() {
        
    }
    
  
    func showAlertMessage(title: String, button: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
}
