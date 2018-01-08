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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getData()
        tableView.reloadData()
    }
}

extension FavoritePlacesListVC: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            DataBaseManager.default.favoritePlaces.remove(at: indexPath.row)
            interactor.deleteIntegrator(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
