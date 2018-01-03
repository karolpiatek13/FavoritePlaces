//
//  PlaceNameCell.swift
//  FavoritePlaces
//
//  Created by Karol on 03.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class PlaceNameCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeNameTextField: UITextField!
    
    var interactor: PlaceNameCellInteractor?

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        interactor?.value = sender.text ?? ""
    }
    
    func configure(interactor: PlaceNameCellInteractor, title: String, value: String) {
        self.interactor = interactor
        placeNameLabel.text = title
        placeNameTextField.text = value
    }
}
