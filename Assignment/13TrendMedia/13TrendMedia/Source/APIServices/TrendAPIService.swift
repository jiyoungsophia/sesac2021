//
//  TrendAPIService.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

struct TrendAPIService {
    static let shared = TrendAPIService()
    
    func fetchTrendData(result: @escaping (Int, JSON) -> () ) {
        let params = [
            "api_key" : Constants.tmdbKey
        ]
        
        AF.request(Endpoint.tmdbTvDayURL,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString)).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
