//
//  Constants.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/11/03.
//

import Foundation

struct Constants {
    static var openweatherKey: String {
       (Bundle.main.infoDictionary?["OPENWEATHER_API_KEY"] as? String) ?? ""
    }
    static var naverKey: String {
        (Bundle.main.infoDictionary?["NAVER_API_KEY"] as? String) ?? ""
    }
    static var naverSecretKey: String {
        (Bundle.main.infoDictionary?["NAVER_SECRET_KEY"] as? String) ?? ""
    }
    
    static var koficKey: String {
        (Bundle.main.infoDictionary?["KOFIC_API_KEY"] as? String) ?? ""
    }
    
    static var kakaoKey: String {
        (Bundle.main.infoDictionary?["KAKAO_API_KEY"] as? String) ?? ""
    }
    
    static var tmdbKey: String {
        (Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String) ?? ""
    }
}

struct Endpoint {
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let visionURL = "https://dapi.kakao.com/v2/vision/face/detect"
    static let tmdbTvDayURL = "https://api.themoviedb.org/3/trending/tv/day"
    static let tmdbImageURL = "https://image.tmdb.org/t/p/w500"
    static let tmdbGenreURL = "https://api.themoviedb.org/3/genre/tv/list"
    static let boxofficeURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
}
