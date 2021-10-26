//
//  Constants.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/25.
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
    
}
