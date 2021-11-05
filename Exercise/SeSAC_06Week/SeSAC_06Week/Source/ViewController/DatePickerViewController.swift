//
//  DatePickerViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }

}
