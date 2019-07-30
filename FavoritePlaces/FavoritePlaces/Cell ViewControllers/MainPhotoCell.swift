//
//  MainPhotoCell.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class MainPhotoCell: UITableViewCell {

    @IBOutlet weak var mainPhoto: UIImageView!
    
    var interactor: MainPhotoCellInteractor?
    
    func configure(interactor: MainPhotoCellInteractor, mainPhoto: UIImage, isEditable: Bool) {
        self.interactor = interactor
        self.mainPhoto.image = mainPhoto
        isUserInteractionEnabled = isEditable
    }
}
