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
    func handleSelection(indexPath: IndexPath)
}

class AddFavoritePlaceInteractor: BaseTableInteractorProtocol {
    
    enum Cell : Int {
        case mainPhoto
        case placeName
        case description
        case galleryCollection
        case address
        case location
        case addButton
    }
    
    var cellOrder: [Cell] = [
        .mainPhoto,
        .placeName
//        .description,
//        .galleryCollection,
//        .address,
//        .location,
//        .addButton
    ]
    
    // Corresponding 'Cell Interactors' for each Cell enum
    var cellInteractors : [Cell:BaseCellInteractor] = [
        .mainPhoto : MainPhotoCellInteractor(),
        .placeName : PlaceNameCellInteractor(title: "PlaceName".localized, value: "cos" )
    ]
    
    func getCellInteractor(for index:Int) -> BaseCellInteractor? {
        return cellInteractors[cellOrder[index]]
    }
    
    func getNumberOfVisibleCells() -> Int {
        return cellOrder.count
    }
    
    func getCellType(for index: Int) -> Cell {
        return cellOrder[index]
    }
    
    func handleSelection(indexPath: IndexPath) {
        switch getCellType(for: indexPath.row) {
        case Cell.mainPhoto:
            // call VC
            break
        default:
            return
        }
    }
}
