//
//  BoxOfficeDetailViewController.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    // pass data 1.
//    var movieTitle: String?
//    var releaseDate: String?
//    var runtime: Int?
//    var overview: String?
//    var rate: Double?
    var movieData: Movie?
    
    
    let pickerList: [String] = ["감자", "고구마", "파인애플", "자두", "복숭아" ]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        titleTobextField.text = pickerList[row]
    }
    
    

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var f: UITextView!
    @IBOutlet weak var d: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //textfield inputview
//        let datePicker = UIDatePicker()
//        datePicker.preferredDatePickerStyle = .wheels // 저장프로퍼티
//
//
//        let pickerView = UIPickerView()
//        titleTextField.inputView = pickerView
//
//
//        overviewTextView.delegate = self
////        f.delegate = self
////        d.delegate = self
//
        // 텍스트뷰 플레이스홀더: 글자, 글자 색상
        overviewTextView.text = "이곳에 줄거리를 남겨보세요"
        overviewTextView.textColor = .lightGray
        
        // pass data2.
//        titleTextField.text = movieTitle
//        overviewTextView.text = overview
//
//        print(runtime, rate, releaseDate)
        titleTextField.text = movieData?.title
        overviewTextView.text = movieData?.overview
        print(movieData?.runtime, movieData?.rate, movieData?.releaseDate)
        
    }
    
    // 커서 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
            
        }
        
    }
    
    // 커서 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "이곳에 줄거리를 남겨보세요"
            textView.textColor = .lightGray
        }
    }
    
}
