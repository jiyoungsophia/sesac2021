//
//  VisionViewController.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/27.
//

import UIKit

class VisionViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        VisionAPIManager.shared.fetchFaceData(image: posterImageView.image!) { code, json in
            print(json)
        }
    }
    
}
