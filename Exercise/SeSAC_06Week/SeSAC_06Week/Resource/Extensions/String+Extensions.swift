//
//  String+Extensions.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/01.
//

import Foundation

extension String {
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
    
}
