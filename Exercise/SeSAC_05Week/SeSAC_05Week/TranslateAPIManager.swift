//
//  TranslateAPIManager.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON


class TranslateAPIManager {
    
    static let shared = TranslateAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchTranslateData(text: String, result: @escaping CompletionHandler ) {
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": Constants.naverKey,
                                   "X-Naver-Client-Secret" : Constants.naverSecretKey
        ]
        
        let parameters = [
            "source" : "ko",
            "target" : "en",
            "text" : text
        ]
        
        //1. 상태코드: validate(statusCode: 200...500)
        //2. 상태코드 분기
        AF.request(Endpoint.translateURL, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                result(code, json) // 여기 code, json을 가지고 뷰컨에서 사용
            
            
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
