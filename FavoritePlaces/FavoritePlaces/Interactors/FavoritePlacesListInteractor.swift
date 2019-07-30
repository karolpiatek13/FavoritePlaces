//
//  FavoritePlacesListInteractor.swift
//  FavoritePlaces
//
//  Created by Karol on 07.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import MapKit

protocol FavoritePlacesListProtocol {
    var favoritePlacesInteractors: [PlaceCellInteractor] { get }
    func getNumberOfVisibleCells() -> Int
    func getData()
    func deleteIntegratorAndCoreData(at index: Int)
    func changePosition(placeInteractor: PlaceCellInteractor, sourceIndex: Int, destinationIndex: Int)
}

class FavoritePlacesListInteractor: FavoritePlacesListProtocol {

    var favoritePlacesInteractors: [PlaceCellInteractor] = []
    var favoritePlaces: [FavoritePlace] = []
    
    func getData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        do {
            favoritePlaces = try context.fetch(FavoritePlace.fetchRequest())
            favoritePlaces = favoritePlaces.sorted(by: { $0.position < $1.position })
            favoritePlacesInteractors = []
            for placeData in favoritePlaces {
                favoritePlacesInteractors.append(PlaceCellInteractor(place: placeData))
            }
        } catch {
            print("Fetching Failed")
        }
    }
    
    func getNumberOfVisibleCells() -> Int {
        return favoritePlacesInteractors.count
    }
    
    func deleteIntegratorAndCoreData(at index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
             else { return }
        let cellInteractor = favoritePlacesInteractors[index]
        let context = appDelegate.persistentContainer.viewContext
        context.delete(cellInteractor.place)
        for (index, place) in favoritePlaces.enumerated() {
            place.position = Int16(index)
        }
        favoritePlacesInteractors.remove(at: index)
        do {
            try context.save()
        } catch {
            print("Deleting Failed")
        }
    }
    
    func changePosition(placeInteractor: PlaceCellInteractor, sourceIndex: Int, destinationIndex: Int) {
        let place = favoritePlaces[sourceIndex]
        favoritePlaces.remove(at: sourceIndex)
        favoritePlacesInteractors.remove(at: sourceIndex)
        favoritePlaces.insert(place, at: destinationIndex)
        favoritePlacesInteractors.insert(placeInteractor, at: destinationIndex)
        for (index, place) in favoritePlaces.enumerated() {
            place.position = Int16(index)
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Moving Failed")
        }
    }
}
