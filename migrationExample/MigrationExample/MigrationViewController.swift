//
//  MigrationViewController.swift
//  MigrationExample
//
//  Created by SeungYeon Yoo on 2022/10/13.
//

import UIKit
import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL)")
        
        // 2. SchemaVersion //현재 몇 스키마 버전인가? 체크하는 코드
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("Schema version: \(version)")
        } catch {
            print(error)
        }

        // 3. test(반복문으로 100개정도를 이름 추가)
        for i in 1...100 {
            let task = Todo(title: "고래밥의 할 일 \(i)", importance: Int.random(in: 1...5))

            try! localRealm.write {
                localRealm.add(task)
            }
        }
    }
}
