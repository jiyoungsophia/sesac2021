//
//  VisionViewController.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/27.
//

import UIKit
import JGProgressHUD

/*
- 카메라는 시뮬레이터에서 테스트 불가능 -> 런타임에러 발생
- ImagePickerViewController -> PHPickerViewController(iOS14+)
- iOS14+: 선택 접근 권한 + UI
 */

class VisionViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    // 언제 보여주고 숨겨야할지
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        progress.show(in: view, animated: true)
        VisionAPIManager.shared.fetchFaceData(image: posterImageView.image!) { code, json in
            print(json)
            
            self.progress.dismiss(animated: true)
        }
    }
}

extension VisionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 사진 촬영하거나, 갤러리에서 사진을 선태간 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        //1. 사진 가져오기
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //2. 로직: 이미지 뷰에 선택한 사진 보여주기
            posterImageView.image = value
            //3. pickerview dismiss
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}
