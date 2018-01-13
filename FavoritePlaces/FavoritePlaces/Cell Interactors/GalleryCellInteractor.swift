//
//  GalleryCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 05.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class GalleryCellInteractor: BaseCellInteractor {
    
    var gallery : [UIImage] = [#imageLiteral(resourceName: "photoPlaceHolder")]
    var delegate: AddFavoritePlaceVC?
    var isEditable = true
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? GalleryCell else { return }
        cell.configure(interactor: self, gallery: gallery)
    }
    
    override var cellType: CellType {
        return GalleryCell.self
    }
}
