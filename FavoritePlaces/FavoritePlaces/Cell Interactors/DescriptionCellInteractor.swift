//
//  DescriptionCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 04.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class DescriptionCellInteractor: BaseCellInteractor {
    
    var title: String
    var value: String?
    
    init(title: String) {
        self.title = title
        super.init()
    }
    
    override func configure(_ cell : UITableViewCell) {
        guard let cell = cell as? DescriptionCell else { return }
        cell.configure(interactor: self, title: title)
    }
    
    override var cellType: AnyClass {
        return DescriptionCell.self
    }
}
