//
//  SecondViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/26/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class SecondViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    @IBOutlet var iconDescView: UIView!
    @IBOutlet var descButton: UIButton!
    @IBOutlet var descIcon: UIImageView!
    @IBOutlet var currentView: UIView!
    @IBOutlet var currentButton: UIButton!
    @IBOutlet var currentIcon: UIImageView!
    
    @IBOutlet var facultyIcon: UIView!
    @IBOutlet var favoriteIcon: UIView!
    @IBOutlet var canteenIcon: UIView!
    @IBOutlet var toiletIcon: UIView!
    @IBOutlet var prayerIcon: UIView!
    @IBOutlet var carParkIcon: UIView!
    
    let managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
    
    var isDescShowing = false
    var isCurrentShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let lat: CLLocationDegrees = 13.7387312
        let lon: CLLocationDegrees = 100.5306979
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    
        addZoneAnnotation()
        
    }

    override func viewDidLayoutSubviews() {
        
        iconDescView.layer.cornerRadius = iconDescView.frame.height / 2
        
        currentView.layer.cornerRadius = currentView.frame.height / 2
        
        facultyIcon.layer.cornerRadius = facultyIcon.frame.height / 2
        facultyIcon.layer.borderWidth = 3
        facultyIcon.layer.borderColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1).cgColor
        
        favoriteIcon.layer.cornerRadius = favoriteIcon.frame.height / 2
        favoriteIcon.layer.borderWidth = 3
        favoriteIcon.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
        
        canteenIcon.layer.cornerRadius = canteenIcon.frame.height / 2
        canteenIcon.layer.borderWidth = 3
        canteenIcon.layer.borderColor = UIColor(red: 0.584, green: 0.824, blue: 0, alpha: 1).cgColor
        
        toiletIcon.layer.cornerRadius = toiletIcon.frame.height / 2
        toiletIcon.layer.borderWidth = 3
        toiletIcon.layer.borderColor = UIColor(red: 0.22, green: 0.5725, blue: 0.878, alpha: 1).cgColor
        
        prayerIcon.layer.cornerRadius = prayerIcon.frame.height / 2
        prayerIcon.layer.borderWidth = 3
        prayerIcon.layer.borderColor = UIColor(red: 0, green: 0.79, blue: 0.725, alpha: 1).cgColor
        
        carParkIcon.layer.cornerRadius = carParkIcon.frame.height / 2
        carParkIcon.layer.borderWidth = 3
        carParkIcon.layer.borderColor = UIColor(red: 0, green: 0.376, blue: 0.725, alpha: 1).cgColor
        
    }

    @IBAction func descClick(_ sender: UIButton) {
        
        if isDescShowing {
            
            isDescShowing = !isDescShowing
            descIcon.image = #imageLiteral(resourceName: "list")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height: 40)
                
            })
            
        } else {
            
            isDescShowing = !isDescShowing
            descIcon.image = #imageLiteral(resourceName: "listPink")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height: 349)
                
            })
            
        }
        
    }
    
    @IBAction func currentClick(_ sender: UIButton) {
        
        if isCurrentShowing {
            
            isCurrentShowing = !isCurrentShowing
            
            currentIcon.image = #imageLiteral(resourceName: "annotation")
            
        } else {
            
            isCurrentShowing = !isCurrentShowing
            
            currentIcon.image = #imageLiteral(resourceName: "annotationPink")
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        map.removeAnnotation(annotation)
        
        annotation.coordinate = userLocation.coordinate
        
        map.addAnnotation(annotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
    }
    
    func addZoneAnnotation() {
        
        let zoneLocations = ZoneData.fetchZoneLocation(inManageobjectcontext: managedObjectContext!)
        
        for zoneLocation in zoneLocations! {
            
            let zoneCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(zoneLocation["latitude"]!)!, longitude: Double(zoneLocation["longitude"]!)!)
            
            let zoneAnnotation = MKPointAnnotation()
            zoneAnnotation.coordinate = zoneCoordinate
            
            map.addAnnotation(zoneAnnotation)
            
            print(zoneAnnotation)
            
        }
        
    }

}
