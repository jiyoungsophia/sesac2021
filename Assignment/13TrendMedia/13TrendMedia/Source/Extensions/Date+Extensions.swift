//
//  Date+Extensions.swift
//  13TrendMedia
//
//  Created by 지영 on 2021/10/26.
//
import UIKit

extension Date {
    var dayBefore: Date {
            return Calendar.current.date(byAdding: .day, value: -1, to: self)!
        }
}
