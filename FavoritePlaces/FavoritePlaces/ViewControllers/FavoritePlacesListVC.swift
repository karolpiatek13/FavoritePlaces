//
//  FavoritePlacesListVC.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class FavoritePlacesListVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: FavoritePlacesListProtocol = FavoritePlacesListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }
}

extension FavoritePlacesListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellInteractor = interactor.getCellInteractor(for: indexPath.row) else {
            return UITableViewCell()
        }
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        cellInteractor.configure(cellView)
        return cellView
    }
}
