//
//  UIViewExtension.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}
