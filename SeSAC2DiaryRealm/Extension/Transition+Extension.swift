//
//  Transition+Extension.swift
//  SeSAC2DiaryRealm
//
//  Created by jack on 2022/08/21.
//
//화면전환

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 전환(Present)
        case presentNavigation //네비게이션 임베드하여 전환(Present)
        case presentFullNavigation //fullscreen으로 present하는데 navigation
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        }
    }
}
