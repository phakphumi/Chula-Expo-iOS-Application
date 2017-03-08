//
//  MapTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var map: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    var latitude = 13.7383829
    var longitude = 100.5298641
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
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
        
    }

}
