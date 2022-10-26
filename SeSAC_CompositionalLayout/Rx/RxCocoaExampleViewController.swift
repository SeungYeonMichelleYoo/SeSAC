//
//  RxCocoaExampleViewController.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/24.
//

import UIKit
import RxCocoa
import RxSwift

class RxCocoaExampleViewController: UIViewController {
    
    @IBOutlet weak var simpleTableView: UITableView!
    @IBOutlet weak var simplePickerView: UIPickerView!
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var signName: UITextField!
    @IBOutlet weak var signEmail: UITextField!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var nickname = Observable.just("Jack")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname
            .bind(to: nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.nickname = "HELLO"
//        }
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    
    //viewcontroller deinit 되면, 알아서 disposed도 동작한다.
    //또는 DisposeBag() 객체를 새롭게 넣어주거나, nil 할당 -> 예외 케이스! (rootvc에 interval이 있다면?)
    deinit {
        print("RxCocoaExampleViewController")
    }
    
    func setOperator() {
        
        //이 코드 쓰는 이유: 네트워크 통신 오류 계속 날 때 5번까지 띄우고 안되면 에러처리하겠다.
//        Observable.repeatElement("Jack")
//            .take(5)
//            .subscribe { value in
//                print("just - \(value)")
//            } onError: { error in
//                print("just - \(error)")
//            } onCompleted: {
//                print("just completed")
//            } onDisposed: {
//                print("just disposed")
//            }
//            .disposed(by: disposeBag)
        
        let intervalObservable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("interval - \(value)")
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval completed")
            } onDisposed: {
                print("interval disposed")
            }
            .disposed(by: disposeBag)
        
        //disposeBag: 리소스 해제 관리
//        1. 시퀀스가 끝날 때 알아서 해제 되기도 함. but bind는 next만 전달할 뿐, complete, error 없음.
//        2. class deinit 자동 해제(bind)
//        3. dispose 직접 호출 -> dipose() 구독하는 것마다 별도로 관리!
//        4. disposeBag을 새롭게 할당하거나, nil 전달.
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.disposeBag = DisposeBag() //한번에 리소스 정리
//        }
                
        let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3]
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func setSign() {
        //ex. 택1(observable), 택2(observable) > 레이블(observer, bind)
        //둘중에 하나만 바뀌더라도 레이블에 변화를...
        //옵셔널 해결 필요없음 : orEmpty
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다."
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        //데이터의 Stream이 바뀐다.(통제한다)
        signName //UITextField
            .rx //Reactive형태로 바뀜
            .text //String?
            .orEmpty //String
        //위에를 하나로 signName.rx.orEmpty 한줄로 쓸 수도 있음.
            .map { $0.count } //Int
            .map { $0 < 4 } //Bool
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
        //.withUnretained(self) //이거 쓰게 되면 밑에 weak self 안써도 되게 된다.
        //위에 문구 쓰는 경우, .subscribe(onNext: { vc, _ in vc.showAlert() } 를 쓴다.
            .subscribe { [weak self] _ in
                self?.showAlert()
            }
            .disposed(by: disposeBag)
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "하하하", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
}
    
    func setSwitch() {
        Observable.of(false) //just? of?
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        //indexPath 대신에 ... indexpath 알 수 없음.. 그래서 rxcommunity에 RxDatasource 있는거..
        simpleTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
        //UI적인건 bind
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: simpleLabel.rx.text)
//            .subscribe(onNext: { value in
//                print(value)
//            })
            .disposed(by: disposeBag)
    }
    
    
}
