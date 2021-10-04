//
//  ViewController.swift
//  Day5_LEDBoard
//
//  Created by 양지영 on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var boardView: UIView!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var textColorButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    func setUI() {
        userTextField.placeholder = "텍스트를 입력하세요"
        
        boardView.layer.cornerRadius = 15
        
        sendButton.layer.cornerRadius = 15
        sendButton.layer.borderWidth = 2
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.setTitleColor(.black, for: .normal)
        
        textColorButton.layer.cornerRadius = 15
        textColorButton.layer.borderWidth = 2
        textColorButton.layer.borderColor = UIColor.black.cgColor
        textColorButton.setTitleColor(.red, for: .normal)
        
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.minimumScaleFactor = 0.1
    }
    
    @IBAction func clickSendButton(_ sender: UIButton) {
        resultLabel.text = userTextField.text
    }
    
    @IBAction func clickTextColorButton(_ sender: UIButton) {
        resultLabel.textColor = random()
    }
    
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    
        }
    
    
    @IBAction func clickTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if boardView.isHidden == false {
            boardView.isHidden = true
        } else {
            boardView.isHidden = false
        }
    }
    
    @IBAction func clickReturnKey(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
}

