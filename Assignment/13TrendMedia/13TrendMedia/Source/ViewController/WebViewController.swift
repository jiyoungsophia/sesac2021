//
//  WebViewController.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/18.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
   
    var titleData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle.title = titleData
        
    }
    



}
