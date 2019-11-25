//
//  String+Color.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import UIKit

extension String {
    
    func toColor() -> UIColor {
        var uppercasedString = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if uppercasedString.hasPrefix("#") {
            uppercasedString.remove(at: uppercasedString.startIndex)
        }
        if uppercasedString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: uppercasedString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
