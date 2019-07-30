//
//  DataExtension.swift
//  FavoritePlaces
//
//  Created by Karol on 13.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

extension Data {
    
    var uiimage: UIImage? { return UIImage(data: self) }
    
    func imageArray() -> [UIImage]? {
        
        guard let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self) as? NSArray
            else {
                print("Unable to convert data to ImageArray")
                return nil
        }
        
        return mySavedData.compactMap { UIImage(data: $0 as! Data) }
    }
}
