//
//  FavoritePlacesListInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

protocol FavoritePlacesListProtocol {
    func getCellInteractor(for index:Int) -> BaseCellInteractor?
    func getNumberOfVisibleCells() -> Int
}

class FavoritePlacesListInteractor: FavoritePlacesListProtocol {
    
    var favoritePlacesInteractors: [PlaceCellInteractor] = [PlaceCellInteractor(),PlaceCellInteractor(),PlaceCellInteractor()]
    
    func getNumberOfVisibleCells() -> Int {
        return favoritePlacesInteractors.count
    }
    
    func getCellInteractor(for index:Int) -> BaseCellInteractor? {
        return favoritePlacesInteractors[index]
    }
}
