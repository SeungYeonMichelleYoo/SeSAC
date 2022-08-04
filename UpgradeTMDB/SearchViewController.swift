//
//  ViewController.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/04.
//

import UIKit

class SearchViewController: UIViewController {
    
    func makeSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Movie"
        searchController.automaticallyShowsCancelButton = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: searchController.searchBar.frame.width, height: 44)
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.title = "Movie"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        makeSearchBar()
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
