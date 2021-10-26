//
//  TranslateViewController.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    
    @IBOutlet weak var targetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": "\(Constants.naverKey)",
                                   "X-Naver-Client-Secret" : "\(Constants.naverSecretKey)"
                                    ]
        
        let parameters = [
            "source" : "ko",
            "target" : "en",
            "text" : sourceTextView.text!
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let targetText = json["message"]["result"]["translatedText"]
                self.targetTextView.text = "\(targetText)"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
