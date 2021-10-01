//
//  SignUpViewController.swift
//  Day3_Netflix
//
//  Created by 양지영 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

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
        
        setUI()
    }
    
    func setTextFieldUI(_ tf: UITextField, placeHolder ph: String, keyBoard kb: UIKeyboardType = .default, secureText st: Bool = false) {
        tf.placeholder = ph
        tf.textColor = .white
        tf.keyboardType = kb
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
    
    
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        print("회원 가입 정보 확인")
        print("ID: \(emailTextField.text ?? "")")
        print("PW: \(passwordTextField.text ?? "")")
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
