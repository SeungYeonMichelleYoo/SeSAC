//
//  PhotoListViewController.swift
//  UsingUnsplashAPI_MVVM
//
//  Created by SeungYeon Yoo on 2022/11/05.
//

import UIKit

class PhotoListViewController: BaseViewController {
    
    var viewModel = ImageViewModel()
    
    var mainView = PhotoListView()
    
    var photoList: [String] = []
    
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totalPage = 0
    var totalCount = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search photos what you want"
 
        addingCollectionView()
        mainView.collectionView.prefetchDataSource = self //페이지네이션
    
        mainView.searchBar.delegate = self
    }

    func addingCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(PhotoListCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoListCollectionViewCell")
        mainView.collectionView.showsVerticalScrollIndicator = false
    }
}

extension PhotoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return photoList.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoListCollectionViewCell", for: indexPath) as? PhotoListCollectionViewCell else {
           return UICollectionViewCell()
       }
     
       let searchimageUrl = URL(string: photoList[indexPath.item])
       DispatchQueue.global().async {
           let data = try? Data(contentsOf: searchimageUrl!)
           if data != nil {
               DispatchQueue.main.async {
                   cell.image.image = UIImage(data: data!)
               }
           }
       }
       return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.url = photoList[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension PhotoListViewController: UISearchBarDelegate {
    
    //검색 버튼 클릭시 실행
    //검색 단어가 바뀌는 것으로 쿼리 정보 수정 후 통신 진행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        if let text = searchBar.text {
            self.startPage = 1
            self.photoList = []
            getData(query: text, start_page: 1)
        }
    }
    
    //취소 버튼 클릭시 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.photoList.removeAll()
        mainView.collectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }

    //서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func getData(query: String, start_page: Int) {
        print("startPage: \(startPage), start_page: \(start_page)")
        viewModel.requestSearchPhoto(query: query, page: start_page) { photo, totalPage, totalCount in
            self.totalPage = totalPage
            self.totalCount = totalCount
            for p in photo {
                self.photoList.append(p.urls.thumb)
            }
//            print(self.photoList.count)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }

}

//페이지네이션
extension PhotoListViewController: UICollectionViewDataSourcePrefetching {
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if photoList.count - 1 == indexPath.item && photoList.count < totalCount {
                startPage += 1
                getData(query: mainView.searchBar.text!, start_page: startPage)
            }
        }
        
//        print("===\(indexPaths)")
    }
    
    //취소: 직접 취소하는 기능을 구현해야 함
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        print("cancel===\(indexPaths)")
    }
}
