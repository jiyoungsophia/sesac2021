//
//  UILabel+Extension.swift
//  SeSAC_05Week
//
//  Created by 지영 on 2021/10/31.
//

import Foundation
import UIKit

extension UILabel {
    func setBorderStyle() {
        self.backgroundColor = .blue
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
