//
//  RealmModel.swift
//  11ShoppingList
//
//  Created by 지영 on 2021/11/02.
//

import Foundation
import RealmSwift

class ShoppingMemo: Object {
    @Persisted var shopMemo: String // 제목(필수)
    @Persisted var check: Bool
    @Persisted var star: Bool
    @Persisted var regDate = Date()
    
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(shopMemo: String, check: Bool, star: Bool, regDate: Date) {
        self.init()
        self.shopMemo = shopMemo
        self.check = false
        self.star = false
        self.regDate = regDate
    }
}
