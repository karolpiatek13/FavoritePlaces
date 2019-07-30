//
//  LacationCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import MapKit

class LocationCellInteractor: CellInteractorProtocol {
    
    var coordinate: CLLocationCoordinate2D?
    var isEditable = true
    
    func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? LocationCell else { return }
        cell.configure(interactor: self, coordinate: coordinate)
    }
    
    var cellType: CellType { return LocationCell.self }
}
