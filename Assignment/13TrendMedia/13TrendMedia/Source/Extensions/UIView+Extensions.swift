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
    }
    
    func setViewTopCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

}
