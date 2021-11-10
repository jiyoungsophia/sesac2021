//
//  OrangeViewController.swift
//  SeSAC_07Week
//
//  Created by 지영 on 2021/11/10.
//

import UIKit

protocol PassDateDelegate {
    func sendTextData(text: String)
}

class OrangeViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var textSpace: String = ""
    
    var buttonActionHandler: (() -> ())?
    
    var delegate: PassDateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = textSpace
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("buttonActionHandler")
        buttonActionHandler?() // 실행만, 구현은 이전 화면에서
        
        //            presentingViewController : 자신(orange)을 호출한 뷰컨(vc)
        //            presentedViewController : 자신이 직접 호출한 뷰컨(new)
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else {return}
            
            //            self.present(vc, animated: true, completion: nil) // 위에서 self.dismiss되면서 self 사라짐
            presentVC.present(vc, animated: true, completion: nil)
            
            print("dismiss completion")
        }
    }
    
    @IBAction func notiButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("firstNoti"), object: nil, userInfo: ["myText": textView.text!,"value": 123])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
