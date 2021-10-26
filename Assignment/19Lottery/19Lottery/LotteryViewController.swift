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
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var no1Label: UILabel!
    @IBOutlet weak var no2Label: UILabel!
    @IBOutlet weak var no3Label: UILabel!
    @IBOutlet weak var no4Label: UILabel!
    @IBOutlet weak var no5Label: UILabel!
    @IBOutlet weak var no6Label: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var lottoNoLabel: UILabel!
    
    
    
    
    let pickerView = UIPickerView()
    
    let lotteryNoList = ["980", "981", "982", "983", "984", "985", "986"]
    var lottoData: [LotteryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPickerView()
        getLottery(986)
        
    }
    
    func getLottery(_ lottoNo: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(lottoNo)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let lottoNo = json["drwNo"].intValue
                let lottoDate = json["drwNoDate"].stringValue
                let lottoNo1 = json["drwtNo1"].intValue
                let lottoNo2 = json["drwtNo2"].intValue
                let lottoNo3 = json["drwtNo3"].intValue
                let lottoNo4 = json["drwtNo4"].intValue
                let lottoNo5 = json["drwtNo5"].intValue
                let lottoNo6 = json["drwtNo6"].intValue
                let lottoBonus = json["bnusNo"].intValue
                
                self.dateLabel.text = lottoDate
                self.no1Label.text = "\(lottoNo1)"
                self.no2Label.text = "\(lottoNo2)"
                self.no3Label.text = "\(lottoNo3)"
                self.no4Label.text = "\(lottoNo4)"
                self.no5Label.text = "\(lottoNo5)"
                self.no6Label.text = "\(lottoNo6)"
                self.bonusLabel.text = "\(lottoBonus)"
                
                self.lottoNoLabel.text = "\(lottoNo)회 당첨결과"
                
                
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
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        

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
        getLottery(Int(lotteryNoList[row]) ?? 986)
    }
    
}
