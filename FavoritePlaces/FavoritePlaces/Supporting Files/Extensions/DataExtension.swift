//
//  DataExtension.swift
//  FavoritePlaces
//
//  Created by Karol on 13.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

extension Data {
    
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
    
    func imageArray() -> [UIImage]? {
        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self) as? NSArray {
            let imgArray = mySavedData.flatMap({
                return UIImage(data: $0 as! Data)
            })
            return imgArray
        }
        else {
            print("Unable to convert data to ImageArray")
            return nil
        }
    }
}
