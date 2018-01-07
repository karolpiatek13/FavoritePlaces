//
//  LocationCell.swift
//  FavoritePlaces
//
//  Created by Karol on 06.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    var interactor: LocationCellInteractor?
    
    func configure(interactor: LocationCellInteractor) {
        self.interactor = interactor
        addTapRecognizer()
    }
    
    func addTapRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        interactor?.coordinate = coordinate
    }
}
