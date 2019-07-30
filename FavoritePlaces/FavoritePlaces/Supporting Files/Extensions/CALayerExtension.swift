//
//  CALayerExtension.swift
//  FavoritePlaces
//
//  Created by Karol Piatek on 29/07/2019.
//  Copyright © 2019 KarolPiatek. All rights reserved.
//

import UIKit

extension CALayer {
    
    func rounded(
        cornerRadius: CGFloat,
        cellInsets: UIEdgeInsets,
        bounds: CGRect
        ) {
        
        let newBounds = bounds.inset(by: cellInsets)
        let roundingCorners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        
        let bezierPath = UIBezierPath(
            roundedRect: newBounds,
            byRoundingCorners: roundingCorners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        mask = shapeLayer
    }
}
