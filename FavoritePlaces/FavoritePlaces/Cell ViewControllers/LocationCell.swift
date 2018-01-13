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
    
    func configure(interactor: LocationCellInteractor, coordinate: CLLocationCoordinate2D?) {
        mapView.delegate = self
        self.interactor = interactor
        if interactor.isEditable {
            addTapRecognizer()
        }
        guard let coordinate = coordinate else { return }
        let annotation = getAnnotation(coordinate: coordinate)
        mapView.addAnnotation(annotation)
    }
    
    func addTapRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        let annotation = getAnnotation(coordinate: coordinate)
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        interactor?.coordinate = coordinate
    }
    
    func getAnnotation(coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        let cllLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(cllLocation, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            annotation.title = placeMark.name
            annotation.subtitle = placeMark.locality
        })
        return annotation
    }
}

extension LocationCell: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        let  pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView.canShowCallout = true
        if interactor?.isEditable ?? false {
            pinView.animatesDrop = true
        }
        pinView.accessibilityLabel = "hello"
        let btn = UIButton(type: .detailDisclosure)
        pinView.rightCalloutAccessoryView = btn
        return pinView
    }
}
