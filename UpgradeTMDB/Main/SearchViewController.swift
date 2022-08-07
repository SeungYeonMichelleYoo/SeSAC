//
//  ViewController.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var maincollectionView: UICollectionView!

    var fetchedList: [MovieModel] = []
    
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
       
        makeSearchBar()
        fetchImage(query: "")
        maincollectionView.delegate = self
        maincollectionView.dataSource = self
        
        maincollectionView.register(UINib(nibName: MainCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
                
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout() //인스턴스 생성(초기화)
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width * 1.3 ) //셀 크기
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        maincollectionView.collectionViewLayout = layout //설정된 값 제공해야 위에서 넣은 수치들이 반영되어 화면에 뜬다.
    }

    func makeSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Movie"
        searchController.automaticallyShowsCancelButton = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: searchController.searchBar.frame.width, height: 44)
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.title = "Movie"
    }
    
    func fetchImage(query: String) {
        //show
        SearchAPIManager.shared.fetchData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount //페이지네이션 관련
            self.fetchedList.append(contentsOf: list)
            
            DispatchQueue.main.async {
                print("reloaded")
              self.maincollectionView.reloadData()
                
                //dismiss
            }
        }
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return MainCollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                      for: indexPath) as! MainCollectionViewCell
        cell.posterImageView.image = nil
        
        cell.infoData(indexPath: indexPath, list: fetchedList)
        cell.configureLabel()
        cell.configureBigView()
        cell.configureButton()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //2] SearchVC->DetailVC 값 전달
        vc.movieData = self.fetchedList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
