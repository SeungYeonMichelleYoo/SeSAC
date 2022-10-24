//
//  DiffableCollectionViewController.swift
//  SeSAC_CompositionalLayout
//
//  Created by SeungYeon Yoo on 2022/10/19.
//

import UIKit
import Kingfisher

class DiffableCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = DiffableViewModel()
    
//    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    //Int: section, String: list의 각각 값들이 들어옴(row에 들어가는 데이터. 근데 indexPath기반이 아니라 model 기반)
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
//        APIService.searchPhoto(query: "apple")
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        collectionView.delegate = self
        
        searchBar.delegate = self
        
        viewModel.photoList.bind { photo in
            //Initial
            var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            //0번째 섹션에 데이터 넣을거야
            snapshot.appendSections([0])
            snapshot.appendItems(photo.results)
            self.dataSource.apply(snapshot)
        }
    }
}

extension DiffableCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//
//        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "확인", style: .cancel)
//        alert.addAction(ok)
//        present(alert, animated: true)
    }
}

extension DiffableCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}

extension DiffableCollectionViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            //String > URL > Data > Image
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)! //thumb: 작은 이미지
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content //왜 이 줄은 async 안에 들어가야 하는가?
                }
            }
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .brown
            cell.backgroundConfiguration = background
        })
        
        //collectionView.dataSource = self
        //numberOfItemsInSection, CellForItemAt을 대체
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
}

