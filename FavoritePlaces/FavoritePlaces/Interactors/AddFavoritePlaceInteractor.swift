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
    func save() -> Bool
}

class AddFavoritePlaceInteractor: BaseTableInteractorProtocol {
    
    enum Cell: Int {
        case mainPhoto
        case placeName
        case description
        case galleryCollection
        case location
        case empty
    }
    
    var cellOrder: [Cell] = [
        .mainPhoto,
        .placeName,
        .description,
        .galleryCollection,
        .location,
    ]
    
    var cellInteractors : [Cell:BaseCellInteractor] = [
        .mainPhoto : MainPhotoCellInteractor(),
        .placeName : PlaceNameCellInteractor(title: "PlaceName".localized, value: "" ),
        .description : DescriptionCellInteractor(title: "Description".localized),
        .galleryCollection : GalleryCellInteractor(),
        .location : LocationCellInteractor(),
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
    
    func save() -> Bool {
        guard let mainPhotoInteractor = cellInteractors[.mainPhoto] as? MainPhotoCellInteractor,
            let placeNameInteractor = cellInteractors[.placeName] as? PlaceNameCellInteractor,
            let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor,
            let galleryInteractor = cellInteractors[.galleryCollection] as? GalleryCellInteractor,
            let locationInteractor = cellInteractors[.location] as? LocationCellInteractor,
            let mainPhoto = mainPhotoInteractor.mainPhoto, !placeNameInteractor.value.isEmpty else { return false }
        
        let favPlace = FavoritePlace(mainPhoto: mainPhoto, placeName: placeNameInteractor.value, description: descriptionInteractor.value, gallery: galleryInteractor.gallery, location: locationInteractor.coordinate)
        DataBaseManager.default.favoritePlaces.append(favPlace)
        
        return true
    }
}
