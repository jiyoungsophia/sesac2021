//
//  TrendModel.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/28.
//

import Foundation

struct TrendModel {
    let movieId: Int
    let genreIDData: [Int]
    let enTitleData: String
    let posterImageData: String
    let rateData: String
    let koTitleData: String
    let releaseData: String
}

struct GenreModel {
    let id: Int
    let name: String
}
