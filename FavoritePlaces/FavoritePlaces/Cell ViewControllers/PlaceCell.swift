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
        mainPhoto.image = place.mainPhoto
        nameLabel.text = place.placeName
        descriptionLabel.text = place.placeDescription
    }
    
    @IBAction func detailsButtonTapped(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : AddFavoritePlaceVC = storyboard.instantiateViewController(withIdentifier: AddFavoritePlaceVC.typeName) as! AddFavoritePlaceVC
        
        let navigationController = UINavigationController(rootViewController: vc)
        
        interactor?.delegate?.present(navigationController, animated: true, completion: nil)
    }
}
