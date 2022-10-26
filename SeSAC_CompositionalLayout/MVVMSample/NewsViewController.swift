//
//  NewsViewController.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    //1. 인스턴스 생성해야 pageNumber count 가져올 수 있다.
    var viewModel = NewsViewModel()
    
    let disposeBag = DisposeBag()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        bindData()
//        configureViews()
    }
    
    func bindData() {
        //numberTextField.text = "3000" 대신 MVVM구조에서는 이걸 ViewModel로 넘긴다.
        viewModel.pageNumber.bind { value in
            print("bind == \(value)")
            self.numberTextField.text = value
        }
        
//        viewModel.dummyNews.bind { item in
//            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
//            snapshot.appendSections([0])
//            snapshot.appendItems(item)
//            self.dataSource.apply(snapshot, animatingDifferences: false)
//        }
        
        viewModel.dummyNews
            .withUnretained(self)
            .bind { (vc, item) in
            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
            snapshot.appendSections([0])
            snapshot.appendItems(item)
            vc.dataSource.apply(snapshot, animatingDifferences: false)
        }
            .disposed(by: disposeBag)
        
        loadButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.loaddummyNews()
            }
        
        resetButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.resetdummyNews()
            }
    }
    
//    func configureViews() {
//        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
//        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
//        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
//    }
    
    @objc func numberTextFieldChanged() {
        //사용자가 계속해서 입력을 마구마구 하면 3자리 단위로 , 를 찍어준다.
        //ViewModel : 1,234 이런식으로 쉼표 찍기 -> VC로 넘겨서(데이터를 매개변수로 전달) viewModel.pageNumber.bind에서 작동
        print(#function)
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(text: text)
    }
    
//    @objc func resetButtonTapped() {
//        viewModel.resetdummyNews()
//    }
//
//    @objc func loadButtonTapped() {
//        viewModel.loaddummyNews()
//    }
}

extension NewsViewController {
    func configureHierarchy() { //addSubView, init, snapkit
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, News.NewsItem> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
