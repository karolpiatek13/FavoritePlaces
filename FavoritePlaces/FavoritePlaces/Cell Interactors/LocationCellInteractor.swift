//
//  LacationCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class LocationCellInteractor: BaseCellInteractor {
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? LocationCell else { return }
    }
    
    override var cellType: AnyClass {
        return LocationCell.self
    }
}
