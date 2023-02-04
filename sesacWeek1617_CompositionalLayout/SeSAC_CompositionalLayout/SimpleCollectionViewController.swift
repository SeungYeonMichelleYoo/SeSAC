//
//  SimpleCollectionCollectionViewController.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/18.
//

import UIKit

struct User: Hashable { //Hashable: Diffable쓰기 위한 준비. Custom으로 만들기 위해선 이 과정이 필요함.
    let id = UUID().uuidString //만약 struct 에서 열거형, 직접만든 class등 있을 때... ? 각각 데이터를 구별하기 위해서 id라는 요소를 별도로 생성하게 된다.(눈에보이진 않지만 구별해주는 객체)
    let name: String //Hashable
    let age: Int //Hashable
}

class SimpleCollectionViewController: UICollectionViewController {
    
//    var list = ["닭곰", "삼계탕", "들기름김", "삼분카레", "콘소메 치킨"]
    var list = [User(name: "뽀로로", age: 3),
                User(name: "뽀로로", age: 3),
                User(name: "해리포터", age: 33),
                User(name: "도라에몽", age: 5)
    ]
    
    //cellForItemAt 전에 생성되어야한다. -> register 코드와 유사한 역할
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, User>!
    
//    var hello: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        hello = {
//            print("hello")
//        }
        
        collectionView.collectionViewLayout = createLayout()
        
        //1. Identifier 없이 가능 - 근데 어떻게 고유한 값을 탐지할까?
        //2. 구조체 단위로 셀에 대한 등록이 이루어짐(CellRegistration 문서 참조)
        
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell() //cell.defaultContentConfiguration()
            
            content.text = itemIdentifier.name
            content.textProperties.color = .red
            
            content.secondaryText = "\(itemIdentifier.age)살"
            content.prefersSideBySideTextAndSecondaryText = false //다음줄로 내리고 싶은 경우
            content.textToSecondaryTextVerticalPadding = 20 //text랑 secondaryText 간격 주기 - 이 숫자가 크면 아래쪽으로 내려가게 됨
            
//            content.image = indexPath.item < 3 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            content.image = itemIdentifier.age < 8 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            content.imageProperties.tintColor = .brown
            
            content.imageProperties.tintColor = .brown
            
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
        
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
    
}

extension SimpleCollectionViewController {
    
    //여기서 반환값을 UICollectionViewLayout으로 하는 이유? : 위에서 collectionView.collectionViewLayout 타입 맞추려고
    private func createLayout() -> UICollectionViewLayout {
        //14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능(List Configuration)
        //컬렉션뷰 스타일 (컬렉션뷰 셀 X)
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false //구분선
        configuration.backgroundColor = .brown
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
