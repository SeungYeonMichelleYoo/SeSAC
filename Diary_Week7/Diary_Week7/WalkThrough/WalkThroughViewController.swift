//
//  WalkThroughViewController.swift
//  Diary_Week7
//
//  Created by SeungYeon Yoo on 2022/08/16.
//

import UIKit

class WalkThroughViewController: UIPageViewController {
    
    //뷰컨트롤러 배열
    var pageViewControllerList: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta //page control 부분 색상 변경(원래 기본 세팅은 검정색임)
        createPageViewController()
        configurePageViewController()
    }
    
    //빈 배열에 뷰컨트롤러 추가
    func createPageViewController() {
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.reuseIdentifier) as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier) as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as! ThirdViewController
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        //display
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }

}

//MARK: - before, after로 왼쪽으로 넘길 때/ 오른쪽으로 넘길 때
extension WalkThroughViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //현재 페이지뷰컨트롤러에 보이는 뷰컨(viewcontroller)의 인덱스 가져오기
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //현재 페이지뷰컨트롤러에 보이는 뷰컨(viewcontroller)의 인덱스 가져오기
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    //MARK: - 폰 하단에 페이지컨트롤 만들기 (아래 2개 메서드 이용)
    //페이지컨트롤
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    //현재 몇번째 페이지인지 알 수 있음
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        
        return index
    }
    
}
