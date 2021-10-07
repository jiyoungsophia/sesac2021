//
//  ViewController.swift
//  08DayCalculator
//
//  Created by 양지영 on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
    }
  
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print(datePicker.date)
        print(sender.date)
        
        //DateFormatter: 1. DateFormat 2. 한국
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd" // 21/10/20 데이트포맷확인
        
        let value = format.string(from: sender.date)
        print(value)
        
        //100일 뒤: TimeInterval, Calendar
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print(afterDate)
    }


}

