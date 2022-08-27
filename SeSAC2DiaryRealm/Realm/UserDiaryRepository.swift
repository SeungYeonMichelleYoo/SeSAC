//
//  UserDiaryRepository.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/26.
//

import Foundation
import RealmSwift

//protocol => 어떤 메서드가 있는지 보기 편하게 프로토콜 만드는게 좋다.

//여러개의 테이블 -> CRUD

protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sort: String) -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func deleteItem(item: UserDiary)
    func addItem(item: UserDiary)
    
}

class UserDiaryRepository {
    
    func fetchDate(date: Date) -> Results<UserDiary> {
        
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date)) //NSPredicate (%@: 매개변수 한 자리)
        
    }
    
    let localRealm = try! Realm() // Realm2. Realm 테이블 경로 가져오기. 이 통로를 통해서 데이터를 가져올거야~ //이건 struct임
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: true) //정렬, 필터, 즐겨찾기
    }
    
    func fetchFilter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'")
    }
    
    //tasks[IndexPath.row] 의 타입이 UserDiary라서 이걸 매개변수로 둠
    //self.tasks[indexPath.row] 값전달(필요한 부분인 HomeVC에서)
    func updateFavorite(item: UserDiary) {
        try! localRealm.write {
            //하나의 레코드에서 특정 컬럼 하나만 변경
            item.favorite = !item.favorite
            //item.favorite.toggle() :위와 같은 뜻임
            
            print("Realm Udpdate Succeed. reloadRows 필요")
        }
    }
    
    func deleteItem(item: UserDiary) {
        
        let id = item.objectId
      
        //realm data delete
        try! self.localRealm.write {
            self.localRealm.delete(item)
        }
        print("objectId: \(item.objectId)")
        //이미지 먼저 삭제 -> 레코드 삭제 순서로 렘 지우면 문제가 안생겼던 이유
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        
        // 데이터베이스에는 실제 이미지를 저장하지 않지만, 만약 이미지를 저장한다고 가정했을 때, objectId에 .jpg 를 붙여서 document폴더에 저장한다.
        // 삭제 시에는 objectId에 .jpg를 붙인 파일이 있는지 여부를 확인 후, 있을 경우에 해당 파일을 삭제한다.
      
    }
    
    //FileManager + Extension에서 가져옴
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
    
    func addItem(item: UserDiary) {
        //MARK: - realm 에 저장
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch let error {
            print(error)
        }
    }
}
