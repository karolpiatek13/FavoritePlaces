//
//  AddPlaceCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 04.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class AddPlaceCellInteractor: BaseCellInteractor {
    
    var buttonTitle: String
    
    init(buttonTitle: String) {
        self.buttonTitle = buttonTitle
        super.init()
    }
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? AddPlaceCell else { return }
        cell.configure(interactor: self, buttonTitle: buttonTitle)
    }
    
    override var cellType: AnyClass {
        return AddPlaceCell.self
    }
}
