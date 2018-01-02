//
//  AddFavoritePlaceVC.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class AddFavoritePlaceVC: UITableViewController {
        
    var interactor : BaseTableInteractorProtocol = AddFavoritePlaceInteractor()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellInteractor = interactor.getCellInteractor(for: indexPath.row) else {
            return UITableViewCell()
        }
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        cellInteractor.configure(cellView)
        return cellView
    }
}
