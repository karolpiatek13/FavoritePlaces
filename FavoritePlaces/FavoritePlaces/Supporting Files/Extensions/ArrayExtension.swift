//
//  ArrayExtension.swift
//  FavoritePlaces
//
//  Created by Karol on 13.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

extension Array where Element: UIImage {

    func coreDataRepresentation() -> Data? {
        let coreDataArray = NSMutableArray()
        
        for img in self {
            guard let imageRepresentation = img.pngData() else {
                print("Unable to represent image as PNG")
                return nil
            }
            let data: NSData = NSData(data: imageRepresentation)
            coreDataArray.add(data)
        }
        
        return NSKeyedArchiver.archivedData(withRootObject: coreDataArray)
    }
}
