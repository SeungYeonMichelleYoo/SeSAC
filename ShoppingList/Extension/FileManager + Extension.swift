//
//  FileManager + Extension.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    //MARK: - HomeVC에서 가져옴
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
        print(FileManager.default.fileExists(atPath: fileURL.path))
        //fileURL이 있는지 물어보는 코드
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path) // 이 위치에 있는걸 이미지로 담기
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
    
        //해당하는 fileURL을 지우는 코드
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    //MARK: - WriteVC에서 가져옴
    //도큐먼트 저장 코드
    func saveImageToDocument(fileName: String, image: UIImage) {
        //default: 싱글톤패턴 . //for, in, first -> 블로그에 잘 나와있음
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } //용량 줄이기
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
}
