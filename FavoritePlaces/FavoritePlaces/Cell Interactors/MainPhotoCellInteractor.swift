//
//  MainPhotoCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class MainPhotoCellInteractor: CellInteractorProtocol {
    
    var mainPhoto: UIImage?
    var isEditable = true
    
    func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? MainPhotoCell else { return }
        cell.configure(interactor: self,
                       mainPhoto: mainPhoto ?? UIImage(named: "photoPlaceHolder")!,
                       isEditable: isEditable)
    }
    
    var cellType: CellType { return MainPhotoCell.self }
}
