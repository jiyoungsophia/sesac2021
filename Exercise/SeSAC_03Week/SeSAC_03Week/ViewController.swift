//
//  ViewController.swift
//  SeSAC_03week
//
//  Created by 양지영 on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // modal : present - dismiss
    @IBAction func memoButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoTableViewController") as! MemoTableViewController
        
        // 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        // 옵션
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
    // push - pop
    @IBAction func boxOfficeButtonCilcked(_ sender: UIButton) {
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        // pass data3.
        vc.titleSpcae = "박스오피스"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

