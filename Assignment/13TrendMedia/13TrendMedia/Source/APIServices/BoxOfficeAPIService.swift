//
//  BoxOfficeAPIService.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/11/03.
//

import Foundation
import Alamofire
import SwiftyJSON

struct BoxOfficeAPIService {
    static let shared = BoxOfficeAPIService()
    
    func fetchBoxOfficeData(searchDate: String, result: @escaping (Int, JSON) -> () ) {
        let params = [
                "key": Constants.koficKey,
                "targetDt": "\(searchDate)"
            ]
        
        AF.request(Endpoint.boxofficeURL,
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
