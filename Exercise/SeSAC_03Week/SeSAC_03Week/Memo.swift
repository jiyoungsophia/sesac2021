//
//  Memo.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/14.
//

import Foundation

// segment control의 index값을 사용하기 위해 Int로 선언하고 연산프로퍼티에서 분기문으로 string값
enum Category: Int {
    case business = 0, personal, others
    
    var description: String {
        switch self {
        case .business:
            return "업무"
        case .personal:
            return "개인"
        case .others:
            return "기타"
        }
    }
}

struct Memo {
    var content: String
    var category: Category
}
