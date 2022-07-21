//
//  MovieCollectionViewController.swift
//  MovieCollectionVC_practice
//
//  Created by SeungYeon Yoo on 2022/07/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {
    

    var movieList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정.
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        //네비게이션 뷰 타이틀 및 오른쪽바버튼아이템 생성
        navigationItem.title = "title"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(searchbuttonClicked))
    }
    
    @objc func searchbuttonClicked() {

        //1. 스토리보드 파일찾기
        let sb = UIStoryboard(name: "Main", bundle: nil) //nil:기본 위치로 가져옴
        
        //2. 스토리보드 내에 있는 뷰 컨트롤러 가져오기
        let vc = sb.instantiateViewController(withIdentifier: "FirstNewViewController") as! FirstNewViewController
        
        //2.5 Navigation controller embed
        let nav = UINavigationController(rootViewController: vc)
        
        //2.5. present할 때의 화면 전환 방식 설정 (옵션)
        nav.modalPresentationStyle = .fullScreen
        
        //3. 화면 전환
        self.present(nav, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let data = movieList.movie[indexPath.item]
        cell.configureCell(data: data)
 
        return cell
    }
    
    
    //셀을 클릭시 Detailed VC로 화면 전환. (push)
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailedViewController")
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
}
