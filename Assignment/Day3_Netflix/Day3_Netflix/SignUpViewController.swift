//
//  SignUpViewController.swift
//  Day3_Netflix
//
//  Created by 양지영 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var infoSwitch: UISwitch!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        setTextFieldUI(emailTextField, placeHolder: "이메일 주소 또는 전화번호", keyBoard: .emailAddress)
        setTextFieldUI(passwordTextField, placeHolder: "비밀번호", secureText: true)
        setTextFieldUI(nicknameTextField, placeHolder: "닉네임")
        setTextFieldUI(locationTextField, placeHolder: "위치")
        setTextFieldUI(codeTextField, placeHolder: "추천 코드 입력", keyBoard: .numberPad)
        codeTextField.delegate = self
        
        setUI()
    }
    
    func setTextFieldUI(_ tf: UITextField, placeHolder ph: String, keyBoard kb: UIKeyboardType = .default, secureText st: Bool = false) {
        tf.placeholder = ph
        tf.textColor = .white
        tf.keyboardType = kb
        // 패스워드 키체인 오류
        tf.textContentType = .oneTimeCode
        tf.isSecureTextEntry = st
        tf.textAlignment = .center
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .gray
    }
    
    
    func setUI(){
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.backgroundColor = .white
        
        infoSwitch.setOn(true, animated: true)
        infoSwitch.onTintColor = .red
        infoSwitch.thumbTintColor = .white
    }
    
    // 코드 텍스트필드 숫자만
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        }
    
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        
        var userEmail : String = ""
        var userPwd : String = ""
        
        userEmail = emailTextField.text ?? ""
        userPwd = passwordTextField.text ?? ""
        
        if ((userEmail.isEmpty) != true) {
            print("ID: \(userEmail)")
        } else {
            print("이메일을 입력하세요")
        }
        
        if ((userPwd.isEmpty) != true) {
            if userPwd.count >= 6 {
                print("PW: \(userPwd)")
            } else {
                print("비밀번호를 6자리 이상 입력하세요")
            }
        } else {
            print("비밀번호를 입력하세요")
        }
        
        
        print("NICK: \(nicknameTextField.text ?? "")")
        print("LOCATION: \(locationTextField.text ?? "")")
        print("CODE: \(codeTextField.text ?? "")")
        
    }

    
 
    @IBAction func infoSwitchClicked(_ sender: UISwitch) {
        
        if sender.isOn {
            nicknameTextField.isHidden = false
            locationTextField.isHidden = false
            codeTextField.isHidden = false
        } else {
            nicknameTextField.isHidden = true
            locationTextField.isHidden = true
            codeTextField.isHidden = true
        }
    }
}
