//
//  AddViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavUI()
         
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setNavUI() {
        navigationItem.title = "일기 작성"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(closeButtonClicked))
        self.navigationController?.navigationBar.isTranslucent = false
    }

}
