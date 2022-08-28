//
//  UserShoplistRepository.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/27.
//

import Foundation
import RealmSwift

//protocol => 어떤 메서드가 있는지 보기 편하게 프로토콜 만드는게 좋다.

class UserShoplistRepository {
    var mainView = ShoppingView()
    
    var localRealm = try! Realm() // Realm2. Realm 테이블 경로 가져오기. 이 통로를 통해서 데이터를 가져올거야~ //이건 struct임
    
    func resetLocalRealm() {
        let username = UserDefaults.standard.string(forKey: "filename") ?? "default"
        
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(username)
        config.fileURL!.appendPathExtension("realm")
        
        localRealm = try! Realm(configuration: config)
    }
    
    func fetch() -> Results<UserShopList> {
        //3. Realm 데이터를 정렬해 tasks에 담기
        return localRealm.objects(UserShopList.self).sorted(byKeyPath: "shoppingThing", ascending: false)
    }
    
    func fetchFilter() -> Results<UserShopList> {
        return self.localRealm.objects(UserShopList.self).filter("shoppingThing CONTAINS '음료'")
    }
    
    func fetchFilterinSearch(_ item: String) -> Results<UserShopList> {
        return self.localRealm.objects(UserShopList.self).filter("shoppingThing CONTAINS '\(item)'")
    }
    
    func fetchSort(_ sort: String) -> Results<UserShopList> {
        return self.localRealm.objects(UserShopList.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func addItem() {
        let data = UserShopList()
        data.shoppingThing = mainView.purchaseTextField.text!

        do {
            try localRealm.write {
                localRealm.add(data)
                mainView.purchaseTextField.text = ""
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateCheck(item: UserShopList) {
            print("checked clicked")
        
        do {
            try self.localRealm.write {
                item.check = !item.check
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateFavorite(item: UserShopList) {
        //realm data update (즐겨찾기 true/false에 따라). 데이터 변경시에 항상 써야함
        
        do {
            try self.localRealm.write {
                //하나의 레코드에서 특정 컬럼 하나만 변경
                item.favorite = !item.favorite
            }
        } catch let error {
            print(error)
        }
    }
    
    func delete(item: UserShopList) {
        //realm data update (즐겨찾기 true/false에 따라). 데이터 변경시에 항상 써야함
        do {
            try self.localRealm.write {
                self.localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
}
