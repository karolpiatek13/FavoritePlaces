//
//  PlaceNameCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 03.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class PlaceNameCellInteractor: BaseCellInteractor {
    
    var title: String
    var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
        super.init()
    }
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? PlaceNameCell else { return }
        cell.configure(interactor: self, title: title, value: value)
    }
    
    override var cellType: AnyClass {
        return PlaceNameCell.self
    }
}
