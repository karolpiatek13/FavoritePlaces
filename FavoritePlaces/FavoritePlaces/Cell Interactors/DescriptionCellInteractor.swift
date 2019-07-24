//
//  DescriptionCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 04.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class DescriptionCellInteractor: CellInteractorProtocol {
    
    var title: String
    var value: String?
    var isEditable = true
    
    init(title: String) {
        self.title = title
    }
    
    func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? DescriptionCell else { return }
        cell.configure(interactor: self, title: title, value: value ?? "", isEditable: isEditable)
    }
    
    var cellType: CellType {
        return DescriptionCell.self
    }
}
