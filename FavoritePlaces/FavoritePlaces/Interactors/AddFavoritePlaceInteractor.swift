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

protocol AddFavoritePlaceProtocol {
    var isEditable: Bool { get set }
    func saveNewPlace() -> Bool
    func saveExistingPlace()
    func setValues(place: FavoritePlace)
    func setDescriptionEditing(editing: Bool)
}

class AddFavoritePlaceInteractor: BaseTableInteractorProtocol, AddFavoritePlaceProtocol {
    
    var place: FavoritePlace?
    var isEditable: Bool = true
    
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
    
    func saveNewPlace() -> Bool {
        guard let mainPhotoInteractor = cellInteractors[.mainPhoto] as? MainPhotoCellInteractor,
            let placeNameInteractor = cellInteractors[.placeName] as? PlaceNameCellInteractor,
            let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor,
            let galleryInteractor = cellInteractors[.galleryCollection] as? GalleryCellInteractor,
            let locationInteractor = cellInteractors[.location] as? LocationCellInteractor,
            let mainPhoto = mainPhotoInteractor.mainPhoto, !placeNameInteractor.value.isEmpty else { return false }
        var gallery = galleryInteractor.gallery
        gallery.remove(at: Constants.galleryPlaceHolder)
        let favPlace = FavoritePlace(mainPhoto: mainPhoto, placeName: placeNameInteractor.value, description: descriptionInteractor.value, gallery: gallery, location: locationInteractor.coordinate)
        DataBaseManager.default.favoritePlaces.append(favPlace)
        
        return true
    }
    
    func saveExistingPlace() {
        guard let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor,
            let place = place else { return }
        place.placeDescription = descriptionInteractor.value
        DataBaseManager.default.favoritePlaces = DataBaseManager.default.favoritePlaces.map { dbPlace in
            guard dbPlace.placeName != place.placeName else {
                return place
            }
            return dbPlace
        }
    }
    
    func setValues(place: FavoritePlace) {
        guard let mainPhotoInteractor = cellInteractors[.mainPhoto] as? MainPhotoCellInteractor,
            let placeNameInteractor = cellInteractors[.placeName] as? PlaceNameCellInteractor,
            let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor,
            let galleryInteractor = cellInteractors[.galleryCollection] as? GalleryCellInteractor,
            let locationInteractor = cellInteractors[.location] as? LocationCellInteractor else { return }
        self.place = place
        isEditable = false
        mainPhotoInteractor.mainPhoto = place.mainPhoto
        mainPhotoInteractor.isEditable = false
        placeNameInteractor.value = place.placeName
        placeNameInteractor.isEditable = false
        descriptionInteractor.value = place.placeDescription
        descriptionInteractor.isEditable = false
        galleryInteractor.gallery = place.gallery ?? []
        galleryInteractor.isEditable = false
        locationInteractor.coordinate = place.location
        locationInteractor.isEditable = false
    }
    
    func setDescriptionEditing(editing: Bool) {
        guard let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor else { return }
        descriptionInteractor.isEditable = editing
    }
}
