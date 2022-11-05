//
//  DetailViewController.swift
//  UsingUnsplashAPI_MVVM
//
//  Created by SeungYeon Yoo on 2022/11/05.
//
import UIKit

class DetailViewController: BaseViewController {
    
    var mainView = DetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
