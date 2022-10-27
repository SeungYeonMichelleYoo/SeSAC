//
//  SubscribeViewController.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/26.
//

import UIKit
import RxSwift
import RxCocoa

class SubscribeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //버튼에서 탭 누르면 -> 레이블에 "안녕 반가워"라고 출력하고 싶은 경우.
        //밑에 1~4까지 모두 같은 코드임 !
        //1.
        button.rx.tap
            .subscribe { [weak self] _ in
                self?.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //2.
        button.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //3. 네트워크 통신이나 파일 다운로드 등 백그라운드 작업?
        button.rx.tap
            .observe(on: MainScheduler.instance) //다른 쓰레드로 동작하게 변경
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //4. bind: subscribe, mainScheduler, error X
        button.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //5. operator로 데이터의 stream 조작
        button
            .rx
            .tap
            .map { "안녕 반가워" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        //6. driver traits: bind + stream이 공유될 수 있음(리소스 낭비 방지, share() )
        button.rx.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)

    }
    
}
