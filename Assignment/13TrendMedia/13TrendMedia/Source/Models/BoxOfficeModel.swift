//
//  BoxOfficeModel.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/26.
//

import Foundation
import RealmSwift

class BoxOfficeModel: Object {
    
    @Persisted var rankNumber: String
    @Persisted var movieTitle: String
    @Persisted var openDate: String
    @Persisted var searchDate: String // 이 키워드로 filter
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(rankNumber: String, movieTitle: String, openDate: String, searchDate: String) {
            self.init()
            self.rankNumber = rankNumber
            self.movieTitle = movieTitle
            self.openDate = openDate
            self.searchDate = searchDate
        }
    
}
