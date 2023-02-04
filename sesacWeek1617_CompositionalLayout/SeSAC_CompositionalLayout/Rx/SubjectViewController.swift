//
//  SubjectViewController.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/25.
//
import UIKit
import RxSwift
import RxCocoa

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    let publish = PublishSubject<Int>() //초기값이 없는 빈 상태
    let behavior = BehaviorSubject(value: 100) //초기값 필수
    let replay = ReplaySubject<Int>.create(bufferSize: 3) //bufferSize에 작성된 이벤트 개수만큼 메모리에서 이벤트를 가지고 있다가, subscribe 직후 한 번에 이벤트를 전달
    let async = AsyncSubject<Int>()
    let disposeBag = DisposeBag()
    let viewModel = SubjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { (row, element, cell) in cell.textLabel?.text = "\(element.name): \(element.age)세 (\(element.number))"
            }
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        //searchBar가 실시간으로 바뀔 때마다 필터
        //value: 결과값
        searchBar.rx.text.orEmpty
            .withUnretained(self)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) //wait(너무 실시간으로 검색되다보니깐 서버통신 때 콜수 생각해서 일부러 조금 기다리게 함)
//            .distinctUntilChanged() //같은 값을 받지 않음
            .subscribe { (vc, value) in
                print("=====\(value)")
                vc.viewModel.filterData(query: value)
            }
            .disposed(by: disposeBag)
        
        newButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.newData()
            }
            .disposed(by: disposeBag)
        
        
//        publishSubject()
//        behaviorSubject()
//        replaySubject()
//        asyncSubject()
    }
}

//extension SubjectViewController {
//
//    func asyncSubject() {
//        async.onNext(100)
//        async.onNext(200)
//        async.onNext(300)
//        async.onNext(400)
//        async.onNext(500)
//
//        async
//            .subscribe { value in
//                print("async - \(value)")
//            } onError: { error in
//                print("async - \(error)")
//            } onCompleted: {
//                print("async completed")
//            } onDisposed: {
//                print("async disposed")
//            }
//            .disposed(by: disposeBag)
//
//        async.onNext(3)
//        async.onNext(4)
//        async.on(.next(5)) //위랑 아래랑 같은 의미임.
//
//        async.onCompleted()
//        //complete된 다음엔 이벤트가 전달 되지 않음.
//
//        async.onNext(6)
//        async.onNext(7)
//    }
//
//
//    func replaySubject() {
//        //Buffersize 메모리, array, 이미지
//
//        replay.onNext(100)
//        replay.onNext(200)
//        replay.onNext(300)
//        replay.onNext(400)
//        replay.onNext(500)
//
//        replay
//            .subscribe { value in
//                print("replay - \(value)")
//            } onError: { error in
//                print("replay - \(error)")
//            } onCompleted: {
//                print("replay completed")
//            } onDisposed: {
//                print("replay disposed")
//            }
//            .disposed(by: disposeBag)
//
//        replay.onNext(3)
//        replay.onNext(4)
//        replay.on(.next(5)) //위랑 아래랑 같은 의미임.
//
//        replay.onCompleted()
//        //complete된 다음엔 이벤트가 전달 되지 않음.
//
//        replay.onNext(6)
//        replay.onNext(7)
//    }
//
//    func behaviorSubject() {
//        //구독 전에 가장 최근 값을 같이 emit
//        behavior.onNext(1)
//        behavior.onNext(2)
//
//        behavior
//            .subscribe { value in
//                print("behavior - \(value)")
//            } onError: { error in
//                print("behavior - \(error)")
//            } onCompleted: {
//                print("behavior completed")
//            } onDisposed: {
//                print("behavior disposed")
//            }
//            .disposed(by: disposeBag)
//
//        behavior.onNext(3)
//        behavior.onNext(4)
//        behavior.on(.next(5)) //위랑 아래랑 같은 의미임.
//
//        behavior.onCompleted()
//        //complete된 다음엔 이벤트가 전달 되지 않음.
//
//        behavior.onNext(6)
//        behavior.onNext(7)
//    }
//
//    func publishSubject() {
//        //초기값이 없는 빈 상태, subscribe 전/error/completed notification 이후의 이벤트 무시.
//        //subscribe 후에 대한 이벤트는 다 처리
//
//        //값을 보낼 수도 있고
//        publish.onNext(1)
//        publish.onNext(2)
//
//        //본인이 구독도 할 수 있다.
//        publish
//            .subscribe { value in
//                print("publish - \(value)")
//            } onError: { error in
//                print("publish - \(error)")
//            } onCompleted: {
//                print("publish completed")
//            } onDisposed: {
//                print("publish disposed")
//            }
//            .disposed(by: disposeBag)
//
//        publish.onNext(3)
//        publish.onNext(4)
//        publish.on(.next(5)) //위랑 아래랑 같은 의미임.
//
//        publish.onCompleted()
//        //complete된 다음엔 이벤트가 전달 되지 않음.
//
//        publish.onNext(6)
//        publish.onNext(7)
//    }
//}
