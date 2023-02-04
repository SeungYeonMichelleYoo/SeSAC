//
//  BackupViewController.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/24.
//
import UIKit
import Zip

class BackupViewController: BaseViewController {
    let mainView = BackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDocumentZipFile()
        
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.returnButton.addTarget(self, action: #selector(returnButtonClicked), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.returnButtonClicked()
            
        }
        
    }

    @objc func backupButtonClicked() {
        
        //백업파일 파일에 대한 것
        var urlPaths = [URL]()
        
        //도큐먼트 위치에 백업 파일 확인 ->1)도큐먼트 확인 2)백업 파일 확인
        
        //MARK: -1)도큐먼트 확인~~~~~~/Documents
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        //MARK: -1)에서 realm 파일 ~~~~~/Documents/default.realm
        //appendingPathComponent 는 . 찍는거임 원래 "d.png"이런식으로 뒤에 붙임(default.realm)이 아닌 경우
        let realmFile = path.appendingPathComponent("default.realm") //realm파일 설정시 파일명을 지정해주지 않았을때 기본 파일명이 default.realm
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)

        //백업 파일을 압축: URL -압축해주는 라이브러리: swift zip github 로 검색
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Archive Location: \(zipFilePath)")
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다.")
        }
    }

    //ActivityViewController 띄우기 (외부로 공유할 수 있게끔)
    func showActivityViewController() {
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("SeSACDiary_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    //MARK: -복원 버튼 클릭시
    @objc func returnButtonClicked() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        //selectedFileUrl.lastpathcomponent: 예를 들자면 sesacdiary1.zip 파일
        //파일이 이미 있다면 그걸 압축 해제
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
           
            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip") //해당 경로에 파일이 있다는걸 알게 되는 순간 밑에 do 에서 압축 풀어줌
            
            do {
                //destination: path = 도큐먼트 위치에서 압축풀거임
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
        } else {
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
        }
        
    }
}
