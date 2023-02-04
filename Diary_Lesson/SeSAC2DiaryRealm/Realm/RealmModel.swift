//
//  RealmModel.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/22.
//

import Foundation
import RealmSwift

//테이블 정의. class 다음에 있는게 테이블 이름임.
//UserDiary: 테이블 이름
//@Persisted: 컬럼
class UserDiary: Object {
    //각 column name 적는거
    @Persisted var diaryTitle: String //제목(필수)
    @Persisted var diaryContent: String? //내용(옵션)
    @Persisted var diaryDate = Date() //작성 날짜(필수)
    @Persisted var regDate = Date() //등록 날짜(필수)
    @Persisted var favorite: Bool //즐겨찾기(필수)
    @Persisted var photo: String?//사진 URL(옵션)
    
    //PrimaryKey= PK(필수): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, regDate: Date, photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.regDate = regDate
        self.favorite = false
        self.photo = photo
    }
}

