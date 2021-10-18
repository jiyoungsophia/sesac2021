//
//  DrinkWaterViewController.swift
//  09DrinkWater
//
//  Created by 양지영 on 2021/10/08.
//

import UIKit

// 마신 양에 따라 식물 자라게 하기 위한 enum
enum WaterPlant {
    case lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9
    
    func setPlantLevel() -> String {
        switch self {
        case .lv1:
            return "1-1"
        case .lv2:
            return "1-2"
        case .lv3:
            return "1-3"
        case .lv4:
            return "1-4"
        case .lv5:
            return "1-5"
        case .lv6:
            return "1-6"
        case .lv7:
            return "1-7"
        case .lv8:
            return "1-8"
        case .lv9:
            return "1-9"
        }
    }
}

class DrinkWaterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var resetButton: UIBarButtonItem!
    @IBOutlet var profileButton: UIBarButtonItem!
    
    @IBOutlet var defaultLabel: UILabel!
    @IBOutlet var totalMlLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!
    
    @IBOutlet var plantImageView: UIImageView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var mlLabel: UILabel!
    
    @IBOutlet var recommendedLabel: UILabel!
    @IBOutlet var drinkButton: UIButton!
    
    // [0]닉네임, [1]물권장량 : userdefaults에 있는 사용자 정보 담을 배열
    var userInfoList : [String] = []
    // [0]마신 총 물의 양, [1]퍼센트 : userdefaults에 넘겨주기 위한 배열
    var waterInfoList : [Float] = []
    
    var recommendedWater : Float = 2000.0
    var totalWater : Int = 0
    var percentWater : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        waterInfoList.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserWaterUI()
        setRecommededLabel()
    }
    
    func setUI() {
        // 네비게이션바
        self.title = "물 마시기"
        self.navigationController?.navigationBar.barTintColor = .mainGreen
        resetButton.image = UIImage(systemName: "arrow.clockwise")
        profileButton.image = UIImage(systemName: "person.circle")
        self.view.backgroundColor = .mainGreen
        
        // 왼쪽 상단 레이블
        setUserWaterUI()
        
        defaultLabel.numberOfLines = 2
        defaultLabel.text = "잘하셨어요!\n오늘 마신 양은"
        defaultLabel.textAlignment = .left
        defaultLabel.font = .systemFont(ofSize: 25)
        
        totalMlLabel.numberOfLines = 1
        totalMlLabel.textAlignment = .left
        totalMlLabel.font = .boldSystemFont(ofSize: 30)
        
        percentLabel.numberOfLines = 1
        percentLabel.textAlignment = .left
        percentLabel.font = .systemFont(ofSize: 17)
                
        // 입력 텍스트필트
        inputTextField.delegate = self
        inputTextField.keyboardType = .numberPad
        inputTextField.borderStyle = .none
        inputTextField.tintColor = .white
        inputTextField.backgroundColor = .mainGreen
        inputTextField.textAlignment = .right
        inputTextField.font = .systemFont(ofSize: 30)
        inputTextField.textColor = .white
        inputTextField.placeholder = "마신 양"
        mlLabel.text = "ml"
        mlLabel.font = .systemFont(ofSize: 30)
        mlLabel.textColor = .white
        
        // 사용자 권장량 레이블
        setRecommededLabel()
        recommendedLabel.font = .systemFont(ofSize: 15)
        recommendedLabel.textColor = .white
        
        // 물마시기 버튼
        drinkButton.backgroundColor = .white
        drinkButton.setTitle("물마시기", for: .normal)
        drinkButton.setTitleColor(.black, for: .normal)
        drinkButton.titleLabel?.font = .systemFont(ofSize: 20)
        drinkButton.contentVerticalAlignment = .top
        
    }
    
    @IBAction func clickDrinkButton(_ sender: UIButton) {
        
        let inputWater = Int(inputTextField.text ?? "") ?? 0
        
        // 총 권장량 받아오기: userInfoList[3] * 1000
        userInfoList =  UserDefaults.standard.stringArray(forKey: "userInfo") ?? [String]()
        if userInfoList.isEmpty != true {
            let floatRecommendedWater = (userInfoList[3] as NSString).floatValue
            recommendedWater = (floatRecommendedWater * 1000)
        }
        
        // 마신 총량 , 퍼센트 업데이트
        waterInfoList = UserDefaults.standard.array(forKey: "waterInfo") as? [Float] ?? [Float]()
        if waterInfoList.isEmpty != true {
            waterInfoList[0] = Float(inputWater) + waterInfoList[0]
            waterInfoList[1] = ( waterInfoList[0] / recommendedWater ) * 100
        } else {
            waterInfoList.append(Float(inputWater))
            let tmpPercent = ( waterInfoList[0] / recommendedWater ) * 100
            waterInfoList.append(tmpPercent)
            
        }
   
        UserDefaults.standard.set(waterInfoList, forKey: "waterInfo")
        
        
        waterInfoList = UserDefaults.standard.array(forKey: "waterInfo") as? [Float] ?? [Float]()
        totalWater = Int(waterInfoList[0])
        percentWater = Int(round(waterInfoList[1]))
        
        if waterInfoList.isEmpty != true {
            totalMlLabel.text = "\(totalWater)ml"
            percentLabel.text = "목표의 \(percentWater)%"
            changePlantImage(percentWater)
        }
        
        setLeftLabelColor()
        inputTextField.text = ""
        
    }
    
    
    @IBAction func clickResetButton(_ sender: UIBarButtonItem) {

        UserDefaults.standard.removeObject(forKey: "waterInfo")
        setUserWaterUI()
        setRecommededLabel()
    }
    
    
    func changePlantImage(_ userWaterLevel: Int) {
        var plantLevel: WaterPlant = .lv1
        
        if userWaterLevel >= 0 && userWaterLevel < 20 {
            plantLevel = .lv1
        } else if userWaterLevel >= 20 && userWaterLevel < 30 {
            plantLevel = .lv2
        } else if userWaterLevel >= 30 && userWaterLevel < 40 {
            plantLevel = .lv3
        } else if userWaterLevel >= 40 && userWaterLevel < 50 {
            plantLevel = .lv4
        } else if userWaterLevel >= 50 && userWaterLevel < 60 {
            plantLevel = .lv5
        } else if userWaterLevel >= 60 && userWaterLevel < 70 {
            plantLevel = .lv6
        } else if userWaterLevel >= 70 && userWaterLevel < 80 {
            plantLevel = .lv7
        } else if userWaterLevel >= 80 && userWaterLevel < 90 {
            plantLevel = .lv8
        } else if userWaterLevel >= 90 {
            plantLevel = .lv9
        }
        
        plantImageView.image = UIImage(named: plantLevel.setPlantLevel())
    }
    
    
    func setUserWaterUI() {
        waterInfoList = UserDefaults.standard.array(forKey: "waterInfo") as? [Float] ?? [Float]()
        
        if waterInfoList.isEmpty == true {
            waterInfoList.append(0.0)
            waterInfoList.append(0.0)
            totalWater = Int(waterInfoList[0])
            percentWater = Int(round(waterInfoList[1]))
            totalMlLabel.text = "\(totalWater)ml"
            percentLabel.text = "목표의 \(percentWater)%"
            changePlantImage(percentWater)
            defaultLabel.textColor = .white
            totalMlLabel.textColor = .white
            percentLabel.textColor = .white
        } else {
            totalWater = Int(waterInfoList[0])
            percentWater = Int(round(waterInfoList[1]))
            totalMlLabel.text = "\(totalWater)ml"
            percentLabel.text = "목표의 \(percentWater)%"
            changePlantImage(percentWater)

            setLeftLabelColor()
        }
    }
    
    func setLeftLabelColor() {
        if waterInfoList[0] > recommendedWater {
            defaultLabel.textColor = .warningRed
            totalMlLabel.textColor = .warningRed
            percentLabel.textColor = .warningRed
        } else {
            defaultLabel.textColor = .white
            totalMlLabel.textColor = .white
            percentLabel.textColor = .white
        }
    }
    
    

    func setRecommededLabel() {
        userInfoList =  UserDefaults.standard.stringArray(forKey: "userInfo") ?? [String]()
        if userInfoList.isEmpty != true {
            recommendedLabel.text = "\(userInfoList[0])님의 하루 물 섭취량은 \(userInfoList[3])L 입니다."
        } else {
            recommendedLabel.text = "사용자 정보를 알려주세요!"
        }
        recommendedLabel.font = .systemFont(ofSize: 15)
        recommendedLabel.textColor = .white
    }
    

    // 입력 글자 수 제한
    @IBAction func textDidChanged(_ sender: UITextField) {
        checkMaxLength(textField: inputTextField, maxLength: 4)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
        
    
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
