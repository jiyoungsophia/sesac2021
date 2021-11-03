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
    @IBOutlet weak var contentImageView: UIImageView!
    
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
            saveImageToDocumentDirectory(imageName: "\(task._id).jpeg", image: contentImageView.image!)
        }
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 1. 이미지 저장할 경로 설정: 도큐먼트 폴더(.documentDirectory), FileManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기(원래는 자동으로 된다고,,)
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path){
            //4-2. 기존경로에 있는 이미지 삭제(원래 자동으로 삭제됨)
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완")
            } catch {
                print("이미지 삭제하지 못했습니다")
            }
        }
        // 5. 이미지 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지를 저장하지 못했습니다")
        }
    }
}
