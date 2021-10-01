//
//  ViewController.swift
//  Day3_Netflix
//
//  Created by 양지영 on 2021/09/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var randomPreview: UIImageView!
    @IBOutlet var previewImage1: UIImageView!
    @IBOutlet var previewImage2: UIImageView!
    @IBOutlet var previewImage3: UIImageView!
    @IBOutlet var randomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPreviewUI(previewImage1, borderColor: UIColor.blue.cgColor)
        setPreviewUI(previewImage2, borderColor: UIColor.purple.cgColor)
        setPreviewUI(previewImage3, borderColor: UIColor.green.cgColor)
        showRandomImage()
        
        randomButton.layer.cornerRadius = 10
    }

    func setPreviewUI(_ previewImage: UIImageView, borderColor c: CGColor) {
        
        previewImage.layer.cornerRadius = 65
        previewImage.layer.borderWidth = 5
        previewImage.layer.borderColor = c
    }
    
    func showRandomImage() {
        let number = Int.random(in: 1...4)
        randomPreview.image = UIImage(named: "previewImg\(number)")
    }
    
    @IBAction func clickRandomButton(_ sender: UIButton) {
        let number = Int.random(in: 1...4)
        randomPreview.image = UIImage(named: "previewImg\(number)")
    }
}

