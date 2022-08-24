//
//  DetailViewController.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/23.
//

import UIKit
import SnapKit
import RealmSwift //Realm 1.

class DetailViewController: BaseViewController {
    var data: UserShopList = UserShopList()
    
    var delegate: SelectImageDelegate? //값 전달 받을 변수 선언
    var selectImage: UIImage? //1.
    var selectIndexPath: IndexPath? //선택된 indexPath에 대해서

    var mainView = DetailView()
    
    //1)값 전달 공간 만들기
    var titlelabel: String? = " "
    
    let localRealm = try! Realm() //Realm2. Realm 테이블 경로 가져오기
    
    //viewDidLoad보다 먼저 호출된다
    override func loadView() { //super.loadView 호출 금지
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3) 값 전달
        mainView.titleLabel.text = titlelabel
    }
    
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: "ImageSearchCollectionViewCell")
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem = closeButton
        let selectButton = UIBarButtonItem(title: "이미지 선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        navigationItem.rightBarButtonItem = selectButton
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //Realm 에 저장 + 이미지가 등록되어있다면 이미지 도큐먼트에 저장 (2가지)
    @objc func selectButtonClicked() {
        //위에서 붙인 ? 옵셔널해제해줌
        guard let selectImage = selectImage else {
            //nil 값일 때 (사용자가 이미지 선택하지 않은 경우 얼럿 메시지 띄워줌). 또는 그냥 토스트메시지 띄우는게 나을 수도 있음. 굳이 확인을 누르게할 필요 없으니깐.
            showAlertMessage(title: "사진을 선택해주세요.", button: "확인")
            return
        }

        delegate?.sendImageData(image: selectImage)
        dismiss(animated: true)
        
        
        //MARK: - 이미지를 저장해야되는 상황에서만 이 코드를 작성
        if let image = self.selectImage {
            saveImageToDocument(fileName: "\(data.objectId).jpg", image: image)
        }
        
    }
}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDummy.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        //위에서 선언한 selectIndexPath와 cellForItemAt에서의 내부매개변수와 같은지 아닌지를 비교해서 선택된거라면 해당 UI를 주고, 아니면 그대로 놔둠
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.yellow.cgColor : nil
        cell.setImage(data: ImageDummy.data[indexPath.item].url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //어떤 셀인지 어떤 이미지를 가지고 올지 어떻게 알지?
//        ImageDummy.data[indexPath.item].url // UIImage로 바로 바꿀 수 있는 방법은 무엇일까? 이렇게해서는 바로 UIImage로 바꿀 수 없어.. cellForItem(at: indexPath) 메서드로 셀을 골라볼수 있을거 같다.
   
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageSearchCollectionViewCell else { return } //타입캐스팅을 통해 imageviewcell 로 내려줌
        
        selectImage = cell.searchImageView.image
        
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
    
    //언제 실행되나?
    //셀이 선택되지 않았을 때 메서드 (deselect)
    //다시 선택했을 때 실행이 안되는데....?
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        selectIndexPath = nil
        selectImage = nil
        collectionView.reloadData()
    }
    
    
}
