//
//  TranslateViewController.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/26.
//

import UIKit
import Network

import Alamofire
import SwiftyJSON


class TranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    var translateText: String = "" {
        didSet {
            targetTextView.text = translateText
            targetTextView.backgroundColor = .purple
        }
    }
    
    // 네트워크 변경 감지 클래스
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네트워크 변경 감지 클래스를 통해 사용자의 네트워크 상태가 변경될 때마다 실행
        //viewdidload여도 실시간으로 감지
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("Wifi")
                } else {
                    print("Others")
                }
                
            } else {
                print("Network Disconnected")
            }
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }
    

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        guard let text = sourceTextView.text else { return }
        // 라이브러리가 해주는 부분
        DispatchQueue.global().async {
            TranslateAPIManager.shared.fetchTranslateData(text: text) { code, json in
                switch code {
                case 200:
                    print(json)
                    
                    DispatchQueue.main.async {
                        self.translateText = json["message"]["result"]["translatedText"].stringValue
                    }
                    
                case 400:
                    print(json)
                    self.translateText = json["errorMessage"].stringValue
                default:
                    print("오류")
                }
            }
        }
        
        

    }
}
