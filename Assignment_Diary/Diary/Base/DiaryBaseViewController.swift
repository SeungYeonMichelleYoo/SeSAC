//
//  DiaryBaseViewController.swift
//  Assignment_Diary
//
//  Created by SeungYeon Yoo on 2022/08/21.
//

import UIKit
import SnapKit

class DiaryBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
