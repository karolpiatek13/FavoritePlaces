//
//  AddFavoritePlaceInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

protocol BaseTableInteractorProtocol {
    func getCellInteractor(for index:Int) -> BaseCellInteractor?
    func getNumberOfVisibleCells() -> Int
}

class AddFavoritePlaceInteractor: BaseTableInteractorProtocol {
    
    // All cells that may appear
    enum Cell : Int {
        case mainPhoto
        case placeName
        case description
        case galleryCollection
        case address
        case location
        case addButton
    }
    
    // The visible cells in the given order
    var cellOrder: [Cell] = [
        .mainPhoto
//        .placeName,
//        .description,
//        .galleryCollection,
//        .address,
//        .location,
//        .addButton
    ]
    
    // Corresponding 'Cell Interactors' for each Cell enum
    var cellInteractors : [Cell:BaseCellInteractor] = [
        .mainPhoto : MainPhotoCellInteractor()
    ]
    
    func getCellInteractor(for index:Int) -> BaseCellInteractor? {
        return cellInteractors[cellOrder[index]]
    }
    
    func getNumberOfVisibleCells() -> Int {
        return cellOrder.count
    }
}
