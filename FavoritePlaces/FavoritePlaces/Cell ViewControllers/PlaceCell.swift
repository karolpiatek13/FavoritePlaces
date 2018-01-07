//
//  PlaceCell.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    var interactor: PlaceCellInteractor?
    
    func configure(interactor: PlaceCellInteractor) {
        self.interactor = interactor
    }
}
