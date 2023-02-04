//
//  RealmModel.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/22.
//

import Foundation
import RealmSwift

class UserShopList: Object {
    @Persisted var shoppingThing: String //쇼핑리스트(필수))
    @Persisted var favorite: Bool//즐겨찾기(필수)
    @Persisted var check: Bool//체크표시(필수)
    
    //PrimaryKey= PK(필수): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(shoppingThing: String) {
        self.init()
        self.shoppingThing = shoppingThing
        self.favorite = false
        self.check = false
    }    
}
