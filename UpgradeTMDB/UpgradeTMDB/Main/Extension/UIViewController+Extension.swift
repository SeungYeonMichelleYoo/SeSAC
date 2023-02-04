//
//  UIViewController+Extension.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/18.
//

import UIKit

extension UIViewController {
    
    func transitionWebViewController<T: WebViewController>(sb: String, url: String, vc: T) {
        //1. 스토리보드 파일찾기
        let sb = UIStoryboard(name: sb, bundle: nil) //nil:기본 위치로 가져옴
        //2. 스토리보드 내에 있는 뷰 컨트롤러 가져오기
        print(String(describing: vc))
        let vc = sb.instantiateViewController(withIdentifier: String(describing: type(of: vc.self))) as! T
        vc.destinationURL = url
        //2.5. present할 때의 화면 전환 방식 설정 - fullscreen
        vc.modalPresentationStyle = .fullScreen
        //3. 화면 전환
        self.present(vc, animated: true)
    }
}
