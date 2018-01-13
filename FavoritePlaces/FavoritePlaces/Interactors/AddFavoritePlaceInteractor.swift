//
//  AddFavoritePlaceInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import MapKit

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
            let mainPhoto = mainPhotoInteractor.mainPhoto, !placeNameInteractor.value.isEmpty,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        var gallery = galleryInteractor.gallery
        gallery.remove(at: Constants.galleryPlaceHolder)

        let context = appDelegate.persistentContainer.viewContext

        let favoritePlace = FavoritePlace(context: context)
        favoritePlace.placeName = placeNameInteractor.value
        favoritePlace.mainPhoto = UIImagePNGRepresentation(mainPhoto)
        favoritePlace.placeDescription = descriptionInteractor.value
        favoritePlace.gallery = gallery.coreDataRepresentation()
        favoritePlace.gegrLat = locationInteractor.coordinate?.latitude ?? 0.0
        favoritePlace.gegrLon = locationInteractor.coordinate?.longitude ?? 0.0
        
        do {
            let favoritePlaces = try context.fetch(FavoritePlace.fetchRequest())
            favoritePlace.position = Int16(favoritePlaces.count)
        } catch {
            print("Fetching Failed")
        }
        
        appDelegate.saveContext()
        
        return true
    }
    
    func saveExistingPlace() {
        guard let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor,
            let place = place else { return }
        place.placeDescription = descriptionInteractor.value
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Fetching Failed")
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
        mainPhotoInteractor.mainPhoto = place.mainPhoto?.toUIImage()
        mainPhotoInteractor.isEditable = false
        placeNameInteractor.value = place.placeName ?? ""
        placeNameInteractor.isEditable = false
        descriptionInteractor.value = place.placeDescription
        descriptionInteractor.isEditable = false
        galleryInteractor.gallery = place.gallery?.imageArray() ?? []
        galleryInteractor.isEditable = false
        locationInteractor.coordinate = CLLocationCoordinate2D(latitude: place.gegrLat, longitude: place.gegrLon)
        locationInteractor.isEditable = false
    }
    
    func setDescriptionEditing(editing: Bool) {
        guard let descriptionInteractor = cellInteractors[.description] as? DescriptionCellInteractor else { return }
        descriptionInteractor.isEditable = editing
    }
}
