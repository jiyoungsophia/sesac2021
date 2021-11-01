//
//  ViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {
    /*
     ======> S-CoreDream-2ExtraLight
     ======> S-CoreDream-5Medium
     ======> S-CoreDream-9Black
     */
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var backupRestoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = LocalizableStrings.welcome_text.localized
        
        welcomeLabel.font = UIFont().main // 11~20
        
        backupRestoreLabel.text = LocalizableStrings.data_backup.localizedSetting
    }
    
    
}

