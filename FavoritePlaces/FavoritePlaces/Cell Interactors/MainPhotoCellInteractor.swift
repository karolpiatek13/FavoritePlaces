//
//  MainPhotoCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class MainPhotoCellInteractor: BaseCellInteractor {
    
    override var cellType: AnyClass {
        return MainPhotoCell.self
    }
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? MainPhotoCell else { return }
        cell.configure(interactor: self, mainPhoto: #imageLiteral(resourceName: "apple"))
    }
}
