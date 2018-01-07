//
//  PlaceCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class PlaceCellInteractor: BaseCellInteractor {
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? PlaceCell else { return }
        cell.configure(interactor: self)
    }
    
    override var cellType: AnyClass {
        return PlaceCell.self
    }
}

