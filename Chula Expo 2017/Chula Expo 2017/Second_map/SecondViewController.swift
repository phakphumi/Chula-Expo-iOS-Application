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
    
    @IBOutlet var navigatorView: UIView!
    @IBOutlet var navigatorPin: UIImageView!
    @IBOutlet var facultyNameEn: UILabel!
    @IBOutlet var facultyNameTh: UILabel!
    @IBOutlet var navigatorCancel: UIView!
    
    let managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
    let annotationIcon = [
                            "LAND": #imageLiteral(resourceName: "LAN-PIN"),
                            "BUSSTOP": #imageLiteral(resourceName: "BUS-PIN1"),
                            "FAVORITE": #imageLiteral(resourceName: "FAV-PIN"),
                            "RESERVED": #imageLiteral(resourceName: "RES-PIN"),
                            "CATEEN": #imageLiteral(resourceName: "FOD-PIN"),
                            "TOILET": #imageLiteral(resourceName: "TOI-PIN"),
                            "CARPARK": #imageLiteral(resourceName: "LAN-PIN"),
                            "MUSLIMPRAYER": #imageLiteral(resourceName: "LAN-PIN"),
                            "ENG": #imageLiteral(resourceName: "ENG-PIN"),
                            "MED": #imageLiteral(resourceName: "LAN-PIN"),
                            "SCI": #imageLiteral(resourceName: "LAN-PIN"),
                            "ACC": #imageLiteral(resourceName: "LAN-PIN"),
                            "POLSCI": #imageLiteral(resourceName: "POLSCI-PIN"),
                            "EDU": #imageLiteral(resourceName: "LAN-PIN"),
                            "PSY": #imageLiteral(resourceName: "LAN-PIN"),
                            "DENT": #imageLiteral(resourceName: "LAN-PIN"),
                            "LAW": #imageLiteral(resourceName: "LAN-PIN"),
                            "COMMARTS": #imageLiteral(resourceName: "LAN-PIN"),
                            "NUR": #imageLiteral(resourceName: "LAN-PIN"),
                            "SPSC": #imageLiteral(resourceName: "LAN-PIN"),
                            "FAA": #imageLiteral(resourceName: "FAA-PIN"),
                            "ARCH": #imageLiteral(resourceName: "ARCH-PIN"),
                            "AHS": #imageLiteral(resourceName: "LAN-PIN"),
                            "VET": #imageLiteral(resourceName: "LAN-PIN"),
                            "ARTS": #imageLiteral(resourceName: "LAN-PIN"),
                            "PHARM": #imageLiteral(resourceName: "LAN-PIN"),
                            "ECON": #imageLiteral(resourceName: "LAN-PIN"),
                            "CUSAR": #imageLiteral(resourceName: "LAN-PIN"),
                            "GRAD": #imageLiteral(resourceName: "GRAND AUDIT"),
                            "SMART": #imageLiteral(resourceName: "SMART-PIN"),
                            "HEALTH": #imageLiteral(resourceName: "LAN-PIN"),
                            "HUMAN": #imageLiteral(resourceName: "LAN-PIN"),
                            "ART": #imageLiteral(resourceName: "LAN-PIN"),
                            "MAINSTAGE": #imageLiteral(resourceName: "LAN-PIN"),
                            "HALL": #imageLiteral(resourceName: "LAN-PIN"),
                            "SALA": #imageLiteral(resourceName: "SALA"),
                            "INTERFORUM": #imageLiteral(resourceName: "LAN-PIN"),
                            "MARKET": #imageLiteral(resourceName: "LAN-PIN"),
                            "INFO": #imageLiteral(resourceName: "INF-PIN")
    
    ]
    
    var facultyTh = [String: String]()
    var facultyEn = [String: String]()
    
    var isDescShowing = false
    var isCurrentShowing = false
    var isNavigatorShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        map.delegate = self
        
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
        
        navigatorView.layer.cornerRadius = 10
//        navigatorView.layer.masksToBounds = true
        navigatorView.layer.shadowOffset = CGSize.zero
        navigatorView.layer.shadowColor = UIColor.black.cgColor
        navigatorView.layer.shadowOpacity = 0.3
        navigatorView.layer.shadowRadius = 2
        
        navigatorCancel.layer.cornerRadius = navigatorCancel.frame.height / 2
        navigatorCancel.layer.shadowOffset = CGSize.zero
        navigatorCancel.layer.shadowColor = UIColor.black.cgColor
        navigatorCancel.layer.shadowOpacity = 0.3
        navigatorCancel.layer.shadowRadius = 2
        
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation || annotation.title! == nil {
            
            return nil
            
        }
        
        let annotationIdentifier = "CustomerIdentifier"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView?.canShowCallout = true
            
            // Resize image
            
            let pinImage = annotationIcon[annotation.title!!]
            
            let size = CGSize(width: 33.67, height: 48.33)
            UIGraphicsBeginImageContext(size)
            pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
            annotationView?.image = resizedImage
            
            let rightButton = UIButton(type: UIButtonType.detailDisclosure)
            annotationView?.rightCalloutAccessoryView = rightButton
            
        } else {
            
            annotationView?.annotation = annotation
            
        }
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let selectedAnnotation = view.annotation as? MKPointAnnotation
        
        if isNavigatorShowing {
            
            navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
            facultyNameTh.text = facultyTh[(selectedAnnotation?.title)!]
            facultyNameEn.text = facultyEn[(selectedAnnotation?.title)!]
            
        } else {
            
            navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
            facultyNameTh.text = facultyTh[(selectedAnnotation?.title)!]
            facultyNameEn.text = facultyEn[(selectedAnnotation?.title)!]
            
            UIView.animate(withDuration: 0.5, animations: {
            
                self.navigatorView.isHidden = false
                self.navigatorCancel.isHidden = false
                
            })
            
            isNavigatorShowing = true
            
        }
        
        
        print(selectedAnnotation?.title)
        
    }
    
    @IBAction func hideNavigator(_ sender: UIButton) {
        
        if isNavigatorShowing {
        
            navigatorCancel.isHidden = true
            navigatorView.isHidden = true
            
            isNavigatorShowing = false
            
        }
        
    }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        // Don't want to show a custom image if the annotation is the user's location.
//        guard !(annotation is MKUserLocation) else {
//            
//            return nil
//            
//        }
//
//        // Better to make this class property
//        let annotationIdentifier = "AnnotationIdentifier"
//        
//        var annotationView: MKAnnotationView?
//        
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        }
//        else {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        
//        if let annotationView = annotationView {
//            // Configure your annotation view here
//            annotationView.canShowCallout = true
//            
//            if var pinImage = annotationIcon[annotation.subtitle!!] {
//                
//                if pinImage == nil {
//                    
//                    pinImage = #imageLiteral(resourceName: "LAN-PIN")
//                    
//                }
//                let size = CGSize(width: 33.67, height: 48.33)
//                UIGraphicsBeginImageContext(size)
//                pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//            
//                annotationView.image = resizedImage
//                
//            }
//            
//        }
//        
//        return annotationView
//        
//        
//        
//    }
    
    func addZoneAnnotation() {
        
        let zoneLocations = ZoneData.fetchZoneLocation(inManageobjectcontext: managedObjectContext!)
        
        for zoneLocation in zoneLocations! {
            
            let zoneCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(zoneLocation["latitude"]!)!, longitude: Double(zoneLocation["longitude"]!)!)
            
            let zoneAnnotation = MKPointAnnotation()
            zoneAnnotation.coordinate = zoneCoordinate
            zoneAnnotation.title = zoneLocation["shortName"]
            facultyEn.updateValue(zoneLocation["name"]!, forKey: zoneLocation["shortName"]!)
            facultyTh.updateValue(zoneLocation["nameTh"]!, forKey: zoneLocation["shortName"]!)
            
            map.addAnnotation(zoneAnnotation)
            
        }
        
    }

}
