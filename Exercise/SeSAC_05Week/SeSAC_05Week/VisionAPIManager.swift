//
//  VisionAPIManager.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/27.
//

import UIKit.UIImage
import Foundation
import Alamofire
import SwiftyJSON

class VisionAPIManager {
    static let shared = VisionAPIManager()
    
    func fetchFaceData(image: UIImage, result: @escaping (Int, JSON) -> () ) {
        
        let header: HTTPHeaders = [
            "Authorization": Constants.kakaoKey
        ]
        
        // UIImage를 바이너리타입으로 변환
        guard let imageData = image.pngData() else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: Endpoint.visionURL, headers: header)
            .validate(statusCode: 200...500).responseJSON { response in
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
