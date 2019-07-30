//
//  GalleryCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 05.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class GalleryCellInteractor: CellInteractorProtocol {
    
    var gallery: [UIImage] = [UIImage(named: "photoPlaceHolder")!]
    var delegate: AddFavoritePlaceVC?
    var isEditable = true
    
    func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? GalleryCell else { return }
        cell.configure(interactor: self, gallery: gallery)
    }
    
    var cellType: CellType { return GalleryCell.self }
}
