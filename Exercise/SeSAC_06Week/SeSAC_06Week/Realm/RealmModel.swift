//
//  RealmModel.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/02.
//

import Foundation
import RealmSwift

// userdiary: 테이블이름
// @persisted: 컬럼
class UserDiary: Object {
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var content: String? // 내용(옵션)
    @Persisted var writeDate = Date() // 작성날짜(필수)
    @Persisted var regDate = Date() // 등록일(옵션)
    @Persisted var favorite: Bool // 즐겨찾기 기능(필수)

    //PK(필수): Int, String, UUID, Object ID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, content: String?, writeDate: Date, regDate: Date) {
        self.init()
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
    }
}
