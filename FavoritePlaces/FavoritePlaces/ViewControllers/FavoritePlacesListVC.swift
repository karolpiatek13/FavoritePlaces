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
        self.navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "FavoritePlacesList.NavBar.Title".localized
        interactor.getData()
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if(editing && !tableView.isEditing){
            tableView.setEditing(true, animated: true)
            editButtonItem.title = "Done".localized
        }else{
            tableView.setEditing(false, animated: true)
             editButtonItem.title = "Edit".localized
        }
    }
}

extension FavoritePlacesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellInteractor = interactor.getCellInteractor(for: indexPath.row) as? PlaceCellInteractor else {
            return UITableViewCell()
        }
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        cellInteractor.configure(cellView)
        cellInteractor.delegate = self
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let movedObject = interactor.getCellInteractor(for: sourceIndexPath.row) as? PlaceCellInteractor else { return }
        interactor.deleteIntegrator(at: sourceIndexPath.row)
        interactor.insertInteractor(placeInteractor: movedObject, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}
