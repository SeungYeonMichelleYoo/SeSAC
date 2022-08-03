//
//  ImageSearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController,                    UICollectionViewDelegate, UICollectionViewDataSource
{
   
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self

        fetchImage()
        
        let layout = UICollectionViewFlowLayout() //인스턴스 생성(초기화)
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)//여백 없이 디바이스 전체를 3으로 나눈다.
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2 ) //셀 크기. height에 width/3 * 1.2하는 이유는 -> 영화포스터처럼 보이게 하려고
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        mainCollectionView.collectionViewLayout = layout //설정된 값 제공해야 위에서 넣은 수치들이 반영되어 화면에 뜬다.
    }
    
    var fetchedList: [String] = []
    
    //fetchImage, requestImage, callRequestImage, getImage... -> response에 따라 네이밍을 설정해주기도 함.
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                             
                let list = json["items"].arrayValue
                for object in list {
                    let link = object["link"].stringValue
                    self.fetchedList.append(link)
                }
                print(self.fetchedList.count)
                DispatchQueue.main.async {
                    self.mainCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        
        }
        let imageUrl = URL(string: fetchedList[indexPath.item])
        cell.imageView.image = UIImage(named: fetchedList[indexPath.item])
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
        }
      }
        return cell
    }
}
