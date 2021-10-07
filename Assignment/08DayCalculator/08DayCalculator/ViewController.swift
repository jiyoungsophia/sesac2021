//
//  ViewController.swift
//  08DayCalculator
//
//  Created by 양지영 on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var backgroundImages: [UIImageView]!
    @IBOutlet var dayLabels: [UILabel]!
    @IBOutlet var backView: [UIView]!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    
    }
    
    func setUI() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        for i in 0..<backgroundImages.count {
            backgroundImages[i].contentMode = .scaleAspectFill
            backgroundImages[i].layer.cornerRadius = 10
        }
        
        for i in 0..<dayLabels.count {
            dayLabels[i].font = .boldSystemFont(ofSize: 18)
            dayLabels[i].textColor = .white
            dayLabels[i].numberOfLines = 2
            dayLabels[i].textAlignment = .center
        }
        
        for i in 0..<backView.count {
            backView[i].layer.backgroundColor = UIColor.clear.cgColor
            backView[i].layer.shadowColor = UIColor.black.cgColor
            backView[i].layer.shadowOffset = CGSize(width: 0, height: 1.0)
            backView[i].layer.shadowOpacity = 0.2
            backView[i].layer.shadowRadius = 4.0
        }
        
        calulateDate(datePicker)
        
    }
  
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        calulateDate(datePicker)
    }

    func calulateDate(_ sender: UIDatePicker) {

        let format = DateFormatter()
        format.dateFormat = "yyyy년\nMM월 dd일"

        for i in 0..<dayLabels.count {
            let afterDate = Date(timeInterval: TimeInterval(86400 * 100 * ( i + 1 )), since: sender.date)
            let resultDate = format.string(from: afterDate)
            dayLabels[i].text = resultDate
        }
    }
}

