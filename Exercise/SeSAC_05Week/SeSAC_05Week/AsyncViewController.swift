//
//  AsyncViewController.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/31.
//

import UIKit

class AsyncViewController: UIViewController {

    @IBOutlet var collectionLabel: [UILabel]!
    
    
    @IBOutlet weak var imageView: UIImageView!
    let url = "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1. 내일 날짜 구하기
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date() ) // Date() 영국표준시가 기본
        print(tomorrow)
        
        //2. 이번주 월요일?
        var component =  calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date() )
        component.weekday = 2
        let mondayWeek = calendar.date(from: component)
        print(mondayWeek)
 
        collectionLabel.forEach { $0.setBorderStyle() }
        
    }
    

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        DispatchQueue.global().async {
            if let url = URL(string: self.url),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
        
     
    }
}
