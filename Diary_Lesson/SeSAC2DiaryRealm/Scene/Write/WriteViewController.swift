//
//  WriteViewController.swift
//  SeSAC2DiaryRealm
//
//  Created by jack on 2022/08/21.
//

import UIKit
import RealmSwift //Realm 1.

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class WriteViewController: BaseViewController {
    
    let mainView = WriteView()
    let repository = UserDiaryRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        //        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        mainView.searchImageButton.addTarget(self, action: #selector(selectImageButtonClicked), for: .touchUpInside)
        mainView.sampleButton.addTarget(self, action: #selector(sampleButtonClicked), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func selectImageButtonClicked() {
        let vc = SearchImageViewController()
        vc.delegate = self //값 전달
        vc.name = "고래밥"
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //Realm 에 저장 + 이미지가 등록되어있다면 이미지 도큐먼트에 저장 (2가지)
    @objc func saveButtonClicked() {
        
        guard let title = mainView.titleTextField.text else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
        
        let task = UserDiary(diaryTitle: title, diaryContent: mainView.contentTextView.text!, diaryDate: Date(), regDate: Date(), photo: nil)
        
        
        repository.addItem(item: task)
        //MARK: - realm 에 저장
        //        do {
        //            try localRealm.write {
        //                localRealm.add(task)
        //            }
        //        } catch let error {
        //            print(error)
        //        }
        
        //MARK: - 이미지를 저장해야되는 상황에서만 이 코드를 작성
        if let image = mainView.userImageView.image {
            saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
        }
        
        dismiss(animated: true)
    }
    
    //Realm Create Sample
    @objc func sampleButtonClicked() {
        
        let task = UserDiary(diaryTitle: "가오늘의 일기\(Int.random(in: 1...1000))", diaryContent: "일기 테스트 내용", diaryDate: Date(), regDate: Date(), photo: nil) // => Record
        
        repository.addItem(item: task)
        //        try! localRealm.write {
        //            localRealm.add(task) //Create
        //            print("Realm Succeed")
        dismiss(animated: true)
    }
}


extension WriteViewController: SelectImageDelegate {
    
    //언제 실행이 되면 될까? 선택버튼을 눌렀을 때
    func sendImageData(image: UIImage) {
        mainView.userImageView.image = image
        print(#function)
    }
}
