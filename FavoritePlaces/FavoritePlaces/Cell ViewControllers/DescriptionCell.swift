//
//  DescriptionCell.swift
//  FavoritePlaces
//
//  Created by Karol on 04.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var interactor: DescriptionCellInteractor?
    
    func configure(interactor: DescriptionCellInteractor, title: String, value: String, isEditable: Bool) {
        self.interactor = interactor
        titleLabel.text = title
        textView.text = value
        isUserInteractionEnabled = isEditable
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
    }
}
