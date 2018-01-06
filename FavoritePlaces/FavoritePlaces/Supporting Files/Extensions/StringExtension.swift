//
//  StringExtension.swift
//  FavoritePlaces
//
//  Created by Karol on 03.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
