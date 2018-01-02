//
//  BaseCellInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class BaseCellInteractor: NSObject {
    var cellType: AnyClass {
        fatalError("You have to override `cellType` variable in the "+String(describing: self)+" interactor.")
    }
    func configure(_ cell: UITableViewCell) {
        fatalError("You have to override `configure` variable in the "+String(describing: self)+" interactor.")
    }
}
