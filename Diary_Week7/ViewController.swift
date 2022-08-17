//
//  ViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/16.
//

import UIKit
import UIFramework //등록한 프레임워크 불러옴

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //viewdidload 에선 얼럿이 뜨지 않으므로 viewdidappear에서
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = KakaoTalkViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
//        testOpen()
//
//        showAlert(title: "테스트얼럿", message: "테스트 메시지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//        }
//
//        let image = UIImage(systemName: "star.fill")!
//        let shareURL = "https://www.apple.com"
//        let text = "WWDC What's New!!!"
//        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        
        OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
        
    }

}

