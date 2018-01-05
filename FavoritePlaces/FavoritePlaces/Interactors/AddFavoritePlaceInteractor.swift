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
    func getCellEnum(index: Int) -> AddFavoritePlaceInteractor.Cell
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
        case empty
    }
    
    var cellOrder: [Cell] = [
        .mainPhoto,
        .placeName,
        .description,
//        .galleryCollection,
//        .address,
//        .location,
        .addButton
    ]
    
    var cellInteractors : [Cell:BaseCellInteractor] = [
        .mainPhoto : MainPhotoCellInteractor(),
        .placeName : PlaceNameCellInteractor(title: "PlaceName".localized, value: "cos" ),
        .description : DescriptionCellInteractor(title: "Description".localized),
        .addButton : AddPlaceCellInteractor(buttonTitle: "AddPlaceButton.Title".localized)
    ]
    
    func getCellInteractor(for index:Int) -> BaseCellInteractor? {
        return cellInteractors[cellOrder[index]]
    }
    
    func getNumberOfVisibleCells() -> Int {
        return cellOrder.count
    }
    
    func getCellEnum(index: Int) -> AddFavoritePlaceInteractor.Cell {
        if cellOrder.indices.contains(index) {
            return cellOrder[index]
        }
        return Cell.empty
    }
}
