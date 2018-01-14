//
//  PlaceCell.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var interactor: PlaceCellInteractor?
    
    func configure(interactor: PlaceCellInteractor, place: FavoritePlace) {
        self.interactor = interactor
        mainPhoto.image = place.mainPhoto?.toUIImage()
        nameLabel.text = place.placeName
        descriptionLabel.text = place.placeDescription
    }
    
    @IBAction func detailsButtonTapped(_ sender: UIButton) {
        guard let place = interactor?.place else { return }
        let vc : AddFavoritePlaceVC = AddFavoritePlaceVC()
        vc.interactor.setValues(place: place)
        interactor?.delegate?.navigationController?.pushViewController(vc, animated: true)
    }
}
