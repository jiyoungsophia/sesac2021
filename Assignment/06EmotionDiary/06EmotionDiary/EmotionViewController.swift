//
//  EmotionViewController.swift
//  06EmotionDiary
//
//  Created by 양지영 on 2021/10/06.
//

import UIKit

// viewDidLoad 때 countArray.text 다 0으로 초기화됨,, 왜그런지 모르거써
class EmotionViewController: UIViewController {
    
    let emotionArray = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "피곤해", "걱정돼"]
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var countArray: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        for i in 0..<emotionArray.count {
            buttonArray[i].setImage(UIImage(named: "mono_slime\(i + 1)"), for: .normal)
            
            labelArray[i].text = emotionArray[i]
            
            let count = UserDefaults.standard.integer(forKey: "number\(i)")
            countArray[i].text = "\(count)"
        }
    }
    
    @IBAction func updateCountClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            updateCount(0)
        case 1:
            updateCount(1)
        case 2:
            updateCount(2)
        case 3:
            updateCount(3)
        case 4:
            updateCount(4)
        case 5:
            updateCount(5)
        case 6:
            updateCount(6)
        case 7:
            updateCount(7)
        case 8:
            updateCount(8)
        default:
            return
        }
    }
    
    
    func updateCount(_ tagNum : Int) {
        
        let count = UserDefaults.standard.integer(forKey: "number\(tagNum)")
        
        UserDefaults.standard.set( count + 1, forKey: "number\(tagNum)")
        
        let updateCount = UserDefaults.standard.integer(forKey: "number\(tagNum)")
        countArray[tagNum].text = "\(updateCount)"
    }
}
