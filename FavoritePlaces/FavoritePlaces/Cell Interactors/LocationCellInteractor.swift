//
//  LacationCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import MapKit

class LocationCellInteractor: BaseCellInteractor {
    
    var coordinate: CLLocationCoordinate2D?
    var isEditable = true
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? LocationCell else { return }
        cell.configure(interactor: self, coordinate: coordinate)
    }
    
    override var cellType: CellType {
        return LocationCell.self
    }
}
