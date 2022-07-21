//
//  DetailedViewController.swift
//  MovieCollectionVC_practice
//
//  Created by SeungYeon Yoo on 2022/07/21.
//

import UIKit

class DetailedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //클릭시 웹뷰 화면으로 이동 (push)
    @IBAction func webGoBtnClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
