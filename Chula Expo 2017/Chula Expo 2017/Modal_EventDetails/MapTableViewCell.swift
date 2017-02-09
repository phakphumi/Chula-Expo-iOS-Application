//
//  MapTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let locationManager = CLLocationManager()
        let annotation = MKPointAnnotation()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let lat: CLLocationDegrees = 13.7383829
        let lon: CLLocationDegrees = 100.5298641
        let latDelta: CLLocationDegrees = 0.02
        let lonDelta: CLLocationDegrees = 0.02
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        annotation.coordinate = location
        
        map.addAnnotation(annotation)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
