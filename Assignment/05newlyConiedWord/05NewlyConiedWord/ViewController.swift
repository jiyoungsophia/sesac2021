//
//  ViewController.swift
//  Day5_newlyConiedWord
//
//  Created by 양지영 on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tagButton1: UIButton!
    @IBOutlet var tagButton2: UIButton!
    @IBOutlet var tagButton3: UIButton!
    @IBOutlet var tagButton4: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    let wordDictionay = ["jmt" : "존맛탱", "별다줄": "별걸 다 줄인다", "스드메": "스튜디오 드레스 메이크업", "삼귀자" : "연애를 시작하기 전 썸 단계", "꾸안꾸" : "꾸민 듯 안꾸민 듯", "만반잘부" : "만나서 반가워 잘 부탁해", "점메추" : "점심 메뉴 추천"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setButtonUI(tagButton1)
        setButtonUI(tagButton2)
        setButtonUI(tagButton3)
        setButtonUI(tagButton4)
    }

    func setUI() {
        // FIXME: stackview border,,
        userTextField.borderStyle = .line
        userTextField.backgroundColor = .white
        
        // textfield left padding
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userTextField.frame.height))
        userTextField.leftView = leftPadding
        userTextField.leftViewMode = UITextField.ViewMode.always
        
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setButtonUI(_ btn : UIButton) {
        // FIXME: button width according to title length
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle(wordDictionay.randomElement()?.key, for: .normal)
    }
    
    func setButtonRandom(_ btn: UIButton) {
        btn.setTitle(wordDictionay.randomElement()?.key, for: .normal)
    }

    @IBAction func clickTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func clickSearchButton(_ sender: UIButton) {
        let temp = userTextField.text?.lowercased() ?? ""
        resultLabel.text = wordDictionay[temp]
        
        view.endEditing(true)
        
        setButtonRandom(tagButton1)
        setButtonRandom(tagButton2)
        setButtonRandom(tagButton3)
        setButtonRandom(tagButton4)
    }
    
    @IBAction func clickTagButton(_ sender: UIButton) {
        userTextField.text = sender.currentTitle
    }
    
    
    
}

