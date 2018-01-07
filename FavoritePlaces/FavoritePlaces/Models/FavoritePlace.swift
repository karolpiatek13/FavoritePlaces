//
//  FavoritePlace.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import MapKit

class FavoritePlace {
    
    //let id: Int64?
    var mainPhoto: UIImage
    var placeName: String
    var placeDescription: String?
    var gallery: [UIImage]?
    var location: CLLocationCoordinate2D?
    
    init(mainPhoto: UIImage, placeName: String, description: String?, gallery: [UIImage]?, location: CLLocationCoordinate2D?) {
        self.mainPhoto = mainPhoto
        self.placeName = placeName
        self.placeDescription = description
        self.gallery = gallery
        self.location = location
    }
}
