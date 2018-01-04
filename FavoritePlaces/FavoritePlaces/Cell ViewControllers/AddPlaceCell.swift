//
//  AddPlaceCell.swift
//  FavoritePlaces
//
//  Created by Karol on 04.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class AddPlaceCell: UITableViewCell {

    @IBOutlet weak var addPlaceButton: UIButton!
    
    var interactor: AddPlaceCellInteractor?
    
    func configure(interactor: AddPlaceCellInteractor, buttonTitle: String) {
        self.interactor = interactor
    }
}
