//
//  AddViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
         
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI() {
        navigationItem.title = LocalizableStrings.writing_diary.localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizableStrings.save_button.localized, style: .plain, target: self, action: #selector(closeButtonClicked))
        self.navigationController?.navigationBar.isTranslucent = false
        
        addTitle.font = UIFont().diary
        addTextView.font = UIFont().diary
    }

}
