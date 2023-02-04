//
//  TabbarViewController.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/27.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    //defaultIndex의 초기값을 0으로 설정해놓고, 아이템이 선택되면 그 아이템의 인덱스가 defaultIndex로 변경되게 함
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.selectedIndex = defaultIndex
    }
    
}

extension TabbarViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let firstNavigationController = UINavigationController()
        let firstTabController = HomeViewController()
        firstNavigationController.addChild(firstTabController)
        ///기본으로 보여질 이미지
        firstNavigationController.tabBarItem.image = UIImage(systemName: "calendar.circle")
        ///선택되었을 때 보여질 이미지
        firstNavigationController.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
        ///탭바 아이템 타이틀
        firstNavigationController.tabBarItem.title = "달력"
        
        let secondNavigationController = UINavigationController()
        let secondTabController = SearchViewController()
        secondNavigationController.addChild(secondTabController)
        ///기본으로 보여질 이미지
        secondNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        ///선택되었을 때 보여질 이미지
        secondNavigationController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        ///탭바 아이템 타이틀
        secondNavigationController.tabBarItem.title = "검색"
        
        
        let thirdNavigationController = UINavigationController()
        let thirdTabController = BackupViewController()
        thirdNavigationController.addChild(thirdTabController)
        ///기본으로 보여질 이미지
        thirdNavigationController.tabBarItem.image = UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle")
        ///선택되었을 때 보여질 이미지
        thirdNavigationController.tabBarItem.selectedImage = UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle.fill")
        ///탭바 아이템 타이틀
        thirdNavigationController.tabBarItem.title = "설정"
        
        let viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController]
        self.setViewControllers(viewControllers, animated: true)
        
        ///TabBar 설정
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor.clear
        tabBar.barTintColor = UIColor.white
        ///선택되었을 때 타이틀 컬러
        tabBar.tintColor = UIColor.orange
        ///선택안된거 타이틀 컬러
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.isHidden = false
        
        ///네비게이션 뷰컨으로 푸쉬했을 때 밑에 바가 사라지지 않도록
        self.hidesBottomBarWhenPushed = false
    }
    
}
