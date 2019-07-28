//
//  StartNavigationController.swift
//  FavoritePlaces
//
//  Created by Karol Piatek on 28/07/2019.
//  Copyright © 2019 KarolPiatek. All rights reserved.
//

import UIKit

class StartNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarStyle()
    }
    
    private func configureNavBarStyle() {
        navigationBar.prefersLargeTitles = true
        navigationBar.barTintColor = Constants.backgroundColor
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor(hexValue: 0x319d66)
    }
}
