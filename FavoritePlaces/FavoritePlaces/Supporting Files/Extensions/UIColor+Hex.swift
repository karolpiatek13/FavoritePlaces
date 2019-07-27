//
//  UIColor+Hex.swift
//  FavoritePlaces
//
//  Created by Karol Piatek on 27/07/2019.
//  Copyright © 2019 KarolPiatek. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexValue: UInt32) {
        
        self.init(
            red: CGFloat((hexValue & 0xFF0000) >> 16) / 255,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255,
            blue: CGFloat(hexValue & 0x0000FF) / 255,
            alpha: CGFloat(1.0)
        )
    }
}
