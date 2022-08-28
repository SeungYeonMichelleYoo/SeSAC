//
//  SearchViewController.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/27.
//

import UIKit
import RealmSwift
import SwiftUI

class SearchViewController: BaseViewController {
    
    let repository = UserShoplistRepository()
    var mainView = SearchView()
    
    //검색의 대상
    var arr: [String] = [ ]
    
    //필터링 되어서 나온 대상
    var tasks: Results<UserShopList>!
    
    var text: String = ""
    
    override func loadView() { //super.loadView 호출 금지
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        
        //shoppingVC에서 저장된 localRealm 파일명이랑 같은 localRealm을 가져옴
        repository.resetLocalRealm()
        
        let dataList = repository.fetch()
        
        if dataList.count > 0 {
            for i in 0...(dataList.count - 1) {
                arr.append(dataList[i].shoppingThing)
            }
        }
        
        mainView.searchTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
    }
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil) //nil인 이유: 결과VC를 따로 하지 X
        searchController.searchBar.placeholder = "Shopping 항목 검색하기"
        searchController.hidesNavigationBarDuringPresentation = false
        
        //searchBar에 text가 업데이트될 때마다 불리는 메소드
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.text = searchController.searchBar.text!     
        //        self.filteredArr =  self.arr.filter { $0.contains(text) }
        //        dump(self.filteredArr)
      
        self.tasks = self.repository.fetchFilterinSearch(text)
        mainView.searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.tasks == nil) {
            return 0
        }
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else { return UITableViewCell() }
        cell.checkImage.image = task.check ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.shoppingImg.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        cell.listLabel.text = task.shoppingThing
        cell.favoriteButton.setImage(task.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
         
        return cell
    }
}
