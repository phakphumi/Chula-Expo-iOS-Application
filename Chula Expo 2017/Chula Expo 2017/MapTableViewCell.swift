//
//  MapTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/9/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func viewDidLoad() {
        // super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        mapView.setRegion(region, animated: true)
        
    }
    
    func createGradientNavBar() {
        
        //Begin, define gradient color shade from RGB(202,92,171) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.73, green: 0.15, blue: 0.56, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.46, green: 0.13, blue: 0.61, alpha: 1).cgColor
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        var navIncludeStatFrame = navigationController!.navigationBar.bounds
        navIncludeStatFrame.size.height += 20
        gradientLayer.frame = navIncludeStatFrame
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //End
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(gradientImage, for: UIBarMetrics.default)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        mapView.removeAnnotation(annotation)
        
        annotation.coordinate = userLocation.coordinate
        
        mapView.addAnnotation(annotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
    }
    
}
