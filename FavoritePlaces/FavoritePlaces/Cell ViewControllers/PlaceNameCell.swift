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
    @IBOutlet weak var placeNameErrorLabel: UILabel!
    
    var interactor: PlaceNameCellInteractor?

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        interactor?.value = sender.text ?? ""
        placeNameTextField.fadeTransition(0.4)
        placeNameLabel.fadeTransition(0.4)
        placeNameTextField.layer.borderColor = UIColor.clear.cgColor
        placeNameErrorLabel.isHidden = true
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        if placeNameTextField.text?.isEmpty ?? true {
            placeNameTextField.fadeTransition(0.4)
            placeNameLabel.fadeTransition(0.4)
            placeNameErrorLabel.text = "PlaceName.Error.Empty".localized
            placeNameErrorLabel.isHidden = false
            placeNameTextField.layer.borderColor = UIColor.red.cgColor
            placeNameTextField.layer.cornerRadius = 8.0
            placeNameTextField.layer.masksToBounds = true
            placeNameTextField.layer.borderWidth = 1.0
        }
    }
    
    func configure(interactor: PlaceNameCellInteractor, title: String, value: String) {
        self.interactor = interactor
        placeNameLabel.text = title
        placeNameTextField.text = value
    }
}
