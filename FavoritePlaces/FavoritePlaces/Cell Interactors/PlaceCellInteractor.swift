//
//  PlaceCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class PlaceCellInteractor: BaseCellInteractor {
    
    var place: FavoritePlace
    var delegate: FavoritePlacesListVC?
    
    init(place: FavoritePlace) {
        self.place = place
    }
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? PlaceCell else { return }
        cell.configure(interactor: self, place: place)
    }
    
    override var cellType: CellType {
        return PlaceCell.self
    }
}

