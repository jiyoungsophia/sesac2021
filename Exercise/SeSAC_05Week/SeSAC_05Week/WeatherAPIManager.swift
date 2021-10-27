//
//  WeatherAPIManager.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WeatherAPIManager {
    static let shared = WeatherAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func getCurrentWeather(result: @escaping CompletionHandler ) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(Constants.openweatherKey)"

        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
