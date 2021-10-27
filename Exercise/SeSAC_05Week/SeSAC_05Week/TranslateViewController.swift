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
    
    var translateText: String = "" {
        didSet {
            targetTextView.text = translateText
            targetTextView.backgroundColor = .purple
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        guard let text = sourceTextView.text else { return }
        TranslateAPIManager.shared.fetchTranslateData(text: text) { code, json in
            switch code {
            case 200:
                print(json)
                self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
                self.translateText = json["errorMessage"].stringValue
            default:
                print("오류")
            }
        }

    }
}
