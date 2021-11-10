//
//  ViewController.swift
//  SeSAC_07Week
//
//  Created by 지영 on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, PassDateDelegate {
    
    func sendTextData(text: String) {
        textView.text = text
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(firstNoti(notification:)), name: .myNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .myNotification, object: nil)
    }
    
    @objc func firstNoti(notification: NSNotification) {
        if let text = notification.userInfo?["myText"] as? String {
            textView.text = text
        }
        print("NOTI!")
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrangeViewController") as? OrangeViewController else { return }
        
        vc.buttonActionHandler = { 
            self.textView.text = vc.textView.text
        }
        vc.textSpace = textView.text
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func notiButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrangeViewController") as? OrangeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrangeViewController") as? OrangeViewController else { return }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension Notification.Name {
    static let myNotification = NSNotification.Name("firstNoti")
}
