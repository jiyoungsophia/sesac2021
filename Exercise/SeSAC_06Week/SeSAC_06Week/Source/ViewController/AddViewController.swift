//
//  AddViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addTextView: UITextView!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        print("Realm is located at: \(localRealm.configuration.fileURL!)")
         
    }
    
    func setUI() {
        navigationItem.title = LocalizableStrings.writing_diary.localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizableStrings.save_button.localized, style: .plain, target: self, action: #selector(saveButtonClicked))
        self.navigationController?.navigationBar.isTranslucent = false
        
        addTitle.placeholder = LocalizableStrings.enter_title.localized
        addTitle.font = UIFont().diary
        addTextView.font = UIFont().diary
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    func saveButtonClicked() {
        let task = UserDiary(diaryTitle: addTitle.text!, content: addTextView.text!, writeDate: Date(), regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
        }
    }

}
