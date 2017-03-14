//
//  MapTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    var latitude = 13.7383829
    var longitude = 100.5298641
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        map.delegate = self
        
    }
    
    override func layoutSubviews() {
        
        map.removeAnnotation(annotation)
        
        let lat: CLLocationDegrees = latitude
        let lon: CLLocationDegrees = longitude
        let latDelta: CLLocationDegrees = 0.02
        let lonDelta: CLLocationDegrees = 0.02
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        annotation.coordinate = location
        
        map.addAnnotation(annotation)
        
        map.showsUserLocation = true
        map.userLocation.title = "ตำแหน่งของฉัน"
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            return nil
            
        }
        
        let annotationIdentifier = "CustomerIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        
        annotationView?.image = #imageLiteral(resourceName: "EVENT-IOS")
        annotationView?.contentMode = .scaleAspectFit
        annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 20, height: 29.01)
        
        return annotationView
        
    }

}
