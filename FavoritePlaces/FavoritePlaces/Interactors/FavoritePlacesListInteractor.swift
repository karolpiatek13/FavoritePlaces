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
    func getData()
    func deleteIntegrator(at index: Int)
    func insertInteractor(placeInteractor: PlaceCellInteractor, at: Int)
}

class FavoritePlacesListInteractor: FavoritePlacesListProtocol {
    
    var favoritePlacesInteractors: [PlaceCellInteractor] = []
    
    func getData() {
        favoritePlacesInteractors = []
        for place in DataBaseManager.default.favoritePlaces {
            favoritePlacesInteractors.append(PlaceCellInteractor(place: place))
        }
    }
    
    func getNumberOfVisibleCells() -> Int {
        return favoritePlacesInteractors.count
    }
    
    func getCellInteractor(for index:Int) -> BaseCellInteractor? {
        return favoritePlacesInteractors[index]
    }
    
    func deleteIntegrator(at index: Int) {
        favoritePlacesInteractors.remove(at: index)
    }
    
    func insertInteractor(placeInteractor: PlaceCellInteractor, at: Int) {
        favoritePlacesInteractors.insert(placeInteractor, at: at)
    }
}
