//
//  FavoritePlacesListVC.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class FavoritePlacesListVC: UITableViewController {

    private let interactor: FavoritePlacesListProtocol = FavoritePlacesListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
        interactor.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInteractor = interactor.favoritePlacesInteractors[indexPath.row]
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        cellInteractor.configure(cellView)
        cellInteractor.delegate = self
        return cellView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = interactor.favoritePlacesInteractors[indexPath.row].place
        let vc: AddFavoritePlaceVC = AddFavoritePlaceVC()
        vc.interactor.setValues(place: place)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.rounded(cornerRadius: 16,
                           cellInsets: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16),
                           bounds: cell.bounds)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = interactor.favoritePlacesInteractors[sourceIndexPath.row]
        interactor.changePosition(placeInteractor: movedObject, sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        tableView.backgroundColor = Constants.backgroundColor
        title = "FavoritePlacesList.NavBar.Title".localized
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.separatorStyle = .none
    }
}
