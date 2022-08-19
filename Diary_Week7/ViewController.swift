//
//  ViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/16.
//

import UIKit
import UIFramework //등록한 프레임워크 불러옴
import SnapKit

class ViewController: UIViewController {
    
    let nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.backgroundColor = .darkGray
        view.tintColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(notification:)), name: NSNotification.Name("saveButtonNotification"), object: nil)
    }
    
    @objc func saveButtonNotificationObserver(notification: NSNotification) {
        
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameButton.setTitle(name, for: .normal)
        }
        if let val = notification.userInfo?["value"] as? Int {
            print(val)
        }
    }
    
    @objc func nameButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("TEST"), object: nil, userInfo: ["name": "\(Int.random(in: 1...100))", "value": 1234])
        
        let vc = ProfileViewController()
        vc.saveButtonActionHandler = { text in
            self.nameButton.setTitle(text, for: .normal)
        }

        present(vc, animated: true)

    
    }

    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
    }
}







    //viewdidload 에선 얼럿이 뜨지 않으므로 viewdidappear에서
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let vc = KakaoTalkViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true)
        
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
        
//        OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
//
//    }

