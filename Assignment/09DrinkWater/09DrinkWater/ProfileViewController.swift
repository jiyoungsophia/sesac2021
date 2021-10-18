//
//  ProfileViewController.swift
//  09DrinkWater
//
//  Created by 양지영 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    
    @IBOutlet var inputTextField: [HoshiTextField]!
    
    
    // 입력받은 사용자 정보 튜플
    var userInfo: (name: String, height: Float, weight: Float, water: Float) = ("", 0, 0, 0.0)
    // 입력받은 사용자 정보를 userdefaults에 넘겨주기 위한 배열
    var userInfoArray: [String] = []
    // userdefaults에 담긴 정보 사용하기 위한 배열
    var userInfoList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTextFieldUI(nicknameTextField, placeHolder: "닉네임을 설정해주세요", keyBoard: .default)
        setTextFieldUI(heightTextField, placeHolder: "키(cm)를 설정해주세요")
        setTextFieldUI(weightTextField, placeHolder: "몸무게(kg)를 설정해주세요")
        
    }
    
    
    func setUI() {
        self.view.backgroundColor = .mainGreen
        saveButton.title = "저장"
        profileImageView.image = UIImage(named: "1-4")
        
        userInfoList = UserDefaults.standard.stringArray(forKey: "userInfo") ?? []
        
        if userInfoList.isEmpty != true {
            nicknameTextField.text = userInfoList[0]
            heightTextField.text = userInfoList[1]
            weightTextField.text = userInfoList[2]
        } else {
            nicknameTextField.text = ""
            heightTextField.text = ""
            weightTextField.text = ""
        }
        
        // func textField 위한 델리게이트
        heightTextField.delegate = self
        weightTextField.delegate = self
    }

    func setTextFieldUI(_ tf: HoshiTextField, placeHolder ph: String, keyBoard kb: UIKeyboardType = .numberPad) {
        tf.backgroundColor = .mainGreen
        tf.borderInactiveColor = .white
        tf.borderActiveColor = .white
        tf.textColor = .white
        tf.tintColor = .white
        tf.font = .systemFont(ofSize: 20)
        tf.placeholder = ph
        tf.placeholderColor = .white
        tf.placeholderFontScale = CGFloat(0.7)
        tf.borderStyle = .line
        tf.autocapitalizationType = .none
        tf.keyboardType = kb
    }
    
    
    @IBAction func clickSaveButton(_ sender: UIBarButtonItem) {
        // 필수 입력 텍스트필드 비었으면 알러트 띄우기
        for field in inputTextField {
                    if !isFilled(field) {
                        saveAlert(field)
                        break
                    }
                }
        calculateWater()
    }
    
    // 알러트 만들기
    func saveAlert(_ field: UITextField) {
            DispatchQueue.main.async {
                var title = ""
                switch field {
                case self.nicknameTextField:
                    title = "닉네임을 입력해주세요"
                case self.heightTextField:
                    title = "키를 입력해주세요"
                case self.weightTextField:
                    title = "몸무게를 입력해주세요"
                default:
                    title = "Error"
                }
                let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "닫기", style: .cancel) { (action) in
                    
                }
                
                controller.addAction(cancelAction)
                self.present(controller, animated: true, completion: nil)
            }
        }
    
    // 텍스트필드 비었는지 확인
    func isFilled(_ textField: UITextField) -> Bool {
            guard let text = textField.text, !text.isEmpty else {
                return false
            }
            return true
        }

    func calculateWater() {
        
        userInfoList.removeAll()
        //userInfoArray append 문제 해결
        userInfoArray.removeAll()
        
        userInfo.name = nicknameTextField.text ?? ""
        userInfo.height = Float(heightTextField.text ?? "") ?? 0
        userInfo.weight = Float(weightTextField.text ?? "") ?? 0
        userInfo.water = Float(( userInfo.height + userInfo.weight ) / 100)
        
        let intHeight = Int(userInfo.height)
        let intWeight = Int(userInfo.weight)
        
        // userdefaults로 넘겨주기 위한 배열 만들기
        userInfoArray.append(userInfo.name)
        userInfoArray.append("\(intHeight)")
        userInfoArray.append("\(intWeight)")
        userInfoArray.append("\(userInfo.water)")
        
        UserDefaults.standard.set(userInfoArray, forKey: "userInfo")
        print(userInfoArray)
    }
    
    // 숫자 텍스트필드에 숫자만 입력 가능하게 하는 함수
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}
