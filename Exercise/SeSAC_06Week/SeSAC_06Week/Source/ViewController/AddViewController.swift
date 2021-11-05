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
    @IBOutlet weak var dateButton: UIButton!
    
    let localRealm = try! Realm()
    
    let imagePicker = UIImagePickerController()
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickContentImageView))
        contentImageView.addGestureRecognizer(tapGesture)
        contentImageView.isUserInteractionEnabled = true
        
        addTitle.placeholder = LocalizableStrings.enter_title.localized
        addTitle.font = UIFont().diary
        addTextView.font = UIFont().diary
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func saveButtonClicked() {
        
//        let format = DateFormatter()
//        format.dateFormat = "yyyy년 MM월 dd일"
        
        guard let date = dateButton.currentTitle, let value = DateFormatter.customFormat.date(from: date) else { return }
        
        let task = UserDiary(diaryTitle: addTitle.text!,
                             content: addTextView.text!,
                             writeDate: value,
                             regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
            if let image = contentImageView.image {
                ImageManager.shared.saveImageToDocumentDirectory(imageName: "\(task._id).jpeg", image: image)
            } else {
                print("이미지 없이 저장")
            }
        }
    }
    
    @objc
    func clickContentImageView() {
        let alert = UIAlertController(title: "사진 가져오기", message: nil, preferredStyle: .actionSheet)
        
        let phtoLibrary = UIAlertAction(title: "사진 앨범", style: .default) { _ in
            self.openPhotoLibrary()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { _ in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(phtoLibrary)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    

    
    
    func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        // alert customizing
        // DatePickerViewController()는 코드만 가져오는것
        // 스토리보드 씬 + 클래스 -> 화면 전환 코드
//        let contentView = DatePickerViewController()
        
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {
            print("datepickerviewcontroller에 오류잇음")
            return
        }
        contentView.view.backgroundColor = .clear
//        contentView.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        contentView.preferredContentSize.height = 200
        alert.setValue(contentView, forKey: "contentViewController")
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
          
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePicker.date)
            
            //확인 버튼 눌렀을 때 버튼의 타이틀 변경
            self.dateButton.setTitle(value, for: .normal)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            contentImageView.image = value
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}

