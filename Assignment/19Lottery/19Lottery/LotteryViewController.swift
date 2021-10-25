//
//  LotteryViewController.swift
//  19Lottery
//
//  Created by 지영 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class LotteryViewController: UIViewController {

    @IBOutlet weak var lotteryNoTextField: UITextField!
    let pickerView = UIPickerView()
    
    let lotteryNoList = ["980", "981", "982", "983", "984", "985", "986"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPickerView()
        getLottery()
        
    }
    
    func getLottery() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=986"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setPickerView(){
        lotteryNoTextField.delegate = self
        
        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216)
        pickerView.delegate = self
        pickerView.dataSource = self

        lotteryNoTextField.inputView = pickerView
    }
}

extension LotteryViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lotteryNoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lotteryNoList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lotteryNoTextField.text = lotteryNoList[row]
        
    }
    
}
