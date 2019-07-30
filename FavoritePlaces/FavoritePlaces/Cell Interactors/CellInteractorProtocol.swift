//
//  CellInteractorProtocol.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

protocol CellInteractorProtocol {
    var cellType: CellType { get }
    
    func configure(_ cell: UITableViewCell)
}
