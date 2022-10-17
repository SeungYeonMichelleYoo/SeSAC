//
//  Todo.swift
//  MigrationExample
//
//  Created by SeungYeon Yoo on 2022/10/13.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var favorite: Double //importance: Int -> Double로 바꿈
    @Persisted var userDescription: String
    @Persisted var count: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.favorite = Double(importance) //타입 일치를 위해 형변환 해줌(Int -> Double)
    }
}
