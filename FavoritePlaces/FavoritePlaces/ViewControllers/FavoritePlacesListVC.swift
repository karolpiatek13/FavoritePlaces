//
//  FavoritePlacesListVC.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class FavoritePlacesListVC: UITableViewController {

    var interactor: FavoritePlacesListProtocol = FavoritePlacesListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.separatorStyle = .none
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localized()
        interactor.getData()
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        if editing && !tableView.isEditing {
            tableView.setEditing(true, animated: true)
            editButtonItem.title = "Done".localized
        } else {
            tableView.setEditing(false, animated: true)
            editButtonItem.title = "Edit".localized
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellInteractor = interactor.getCellInteractor(for: indexPath.row) as? PlaceCellInteractor else {
            return UITableViewCell()
        }
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        cellInteractor.configure(cellView)
        cellInteractor.delegate = self
        return cellView
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            interactor.deleteIntegratorAndCoreData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let movedObject = interactor.getCellInteractor(for: sourceIndexPath.row) as? PlaceCellInteractor else { return }
        interactor.changePosition(placeInteractor: movedObject, sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        tableView.backgroundColor = Constants.backgroundColor
    }
    
    private func localized() {
        title = "FavoritePlacesList.NavBar.Title".localized
    }
}
