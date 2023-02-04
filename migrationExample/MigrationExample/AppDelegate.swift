//
//  AppDelegate.swift
//  MigrationExample
//
//  Created by SeungYeon Yoo on 2022/10/13.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        aboutRealmMigration()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//코드가 복잡해지면 밑에 extension으로 따로 빼두고 위에서 함수 메소드만 적어두기
extension AppDelegate {
    
    func aboutRealmMigration() {
        //deleteRealmIfMigrationNeeded: 마이그레이션이 필요한 경우 기존 렘 삭제 - 앱 출시 땐 쓰지 말아야 하는 코드 (realm browser 닫고 다시 열기!)
//        let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true) //0부터 기존 사용자의 렘 다 삭제해줘
        
        //밑에 블록에서 달라진걸 명시
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            
            //컬럼, 테이블 단순 추가 삭제의 경우엔 별도 코드가 필요 없다
            if oldSchemaVersion < 1 { //사용자의 버전이 0인 경우
                
            } //~컬럼 추가,삭제를 주석으로 표시해도 되고. 아님 git commit 기록을 보는 방법으로 확인.
            
            //컬럼, 테이블 단순 추가 삭제의 경우엔 별도 코드가 필요 없다
            if oldSchemaVersion < 2 { //사용자의 버전이 1인 경우.. 어 아직 2가 아니네? 하고 이 구문을 타게 된다. - 이 조건문 else if 쓰지 않음. 각각의 버전을 다 타고 체크해야해서.
                
            }
            
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
            
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
//                    new["userDescription"] = "샘플입니다" (새로 생성된 컬럼에 대해서만 초기값을 넣어주는 건 가능)
                    new["userDescription"] = "안녕하세요 \(old["title"]) 의 중요도는 \(old["favorite"]!) 입니다."
                }
            }
            
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    new["count"] = 100
                }
            }
            
            if oldSchemaVersion < 6 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                 
                    new["favorite"] = old["favorite"] //Int->Double로 바뀌는거라서 이렇게 간단하게 써도 됨
                }
            }
        }
        
        
        Realm.Configuration.defaultConfiguration = config
    }
}
