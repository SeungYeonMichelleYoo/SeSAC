//
//  BackupViewController.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/24.
//
import UIKit
import SnapKit

class BackupViewController: UIViewController {
    let mainView = BackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
}
