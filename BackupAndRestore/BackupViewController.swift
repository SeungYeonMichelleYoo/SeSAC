//
//  BackupViewController.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/25.
//
import UIKit
import Zip
import RealmSwift

class BackupViewController: BaseViewController {
    let mainView = BackupView()
    
    let localRealm = try! Realm()
    var tasks: Results<UserShopList>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(UserShopList.self)
        
        fetchDocumentZipFile()
        
        
        self.navigationItem.title = "백업 및 복원"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkbuttonClicked))
        
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.returnButton.addTarget(self, action: #selector(returnButtonClicked), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.returnButtonClicked()
            
        }
        
    }
    
    @objc func xmarkbuttonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc func backupButtonClicked() {
        
        //백업파일 파일에 대한 것
        var urlPaths = [URL]()
        
        //도큐먼트 위치에 백업 파일 확인 ->1)도큐먼트 확인 2)백업 파일 확인
        
        //MARK: -1)도큐먼트 확인~~~~~~/Documents
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.", button: "확인")
            return
        }
        
        //MARK: -1)에서 realm 파일 ~~~~~/Documents/default.realm
        let realmFile = path.appendingPathComponent("default.realm") //realm파일 설정시 파일명을 지정해주지 않았을때 기본 파일명이 default.realm
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다.", button: "확인")
            return
        }
        let newName = String(Int(Date().timeIntervalSince1970))
        let newFile = path.appendingPathComponent("\(newName).realm")
        do {
            try FileManager.default.copyItem(at: URL(fileURLWithPath: realmFile.path), to: URL(fileURLWithPath: newFile.path))
        } catch (let error) {
            print(error)
        }
        
        let textPath: URL = path.appendingPathComponent("name.txt")
        if let data: Data = newName.data(using: String.Encoding.utf8) { // String to Data
            do {
                try data.write(to: textPath) // 위 data를 "hi.txt"에 쓰기
            } catch let e {
                print(e.localizedDescription)
            }
        }        //압축 대상을 urlPaths에 append
        urlPaths.append(URL(string: newFile.path)!)
        urlPaths.append(URL(string: textPath.path)!)
        
        //MARK: - img 추가
        if tasks.count > 0 {
            for i in 0...(tasks.count-1) {
                let filename = "\(tasks[i].objectId).jpg"
                if checkFileExists(fileName: filename) {
                    let filePath = path.appendingPathComponent(filename)
                    urlPaths.append(URL(string: filePath.path)!)
                }
            }
        }

        //백업 파일을 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "Shopping_1")
            print("Archive Location: \(zipFilePath)")
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다.", button: "확인")
        }
    }
    
    //ActivityViewController 띄우기 (외부로 공유할 수 있게끔)
    func showActivityViewController() {
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.", button: "확인")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("Shopping_1.zip")
        
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
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.", button: "확인")
            return
        }
        
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.", button: "확인")
            return
        }
        
        //selectedFileUrl.lastpathcomponent: 예를 들자면 sesacdiary1.zip 파일
        //파일이 이미 있다면 그걸 압축 해제
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
           
            let fileURL = path.appendingPathComponent("Shopping_1.zip") //해당 경로에 파일이 있다는걸 알게 되는 순간 밑에 do 에서 압축 풀어줌
            
            do {
                //destination: path = 도큐먼트 위치에서 압축풀거임
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.", button: "확인")
                    
                    do {
                        let dataFromPath: Data = try Data(contentsOf: path.appendingPathComponent("name.txt")) // URL을 불러와서 Data타입으로 초기화
                        let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
                        print(text) // 출력
                        UserDefaults.standard.set(text, forKey: "filename")
                    } catch let e {
                        print(e.localizedDescription)
                    }
                    
                    
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.", button: "확인")
            }
            
        } else {
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("Shopping_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.", button: "확인")
                    do {
                        let dataFromPath: Data = try Data(contentsOf: path.appendingPathComponent("name.txt")) // URL을 불러와서 Data타입으로 초기화
                        let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
                        print(text) // 출력
                        UserDefaults.standard.set(text, forKey: "filename")
                    } catch let e {
                        print(e.localizedDescription)
                    }
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.", button: "확인")
            }
        }
        
    }
}

