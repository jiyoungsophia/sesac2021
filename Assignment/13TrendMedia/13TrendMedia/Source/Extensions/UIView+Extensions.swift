//
//  UIView+Extensions.swift
//  13TrendMedia
//
//  Created by 양지영 on 2021/10/16.
//

import Foundation
import UIKit

extension UIView {
func setViewShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
//        self.clipsToBounds = true
    }
    
    func setViewCornerRadius() {
        self.layer.cornerRadius = 20
        let colors = [ UIColor.bookPink, UIColor.bookBlue, UIColor.bookCoral, UIColor.bookCoral, UIColor.bookPurple, UIColor.bookViolet ]
        self.backgroundColor = colors.randomElement() as? UIColor
    }
    
    func setViewTopCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

}
