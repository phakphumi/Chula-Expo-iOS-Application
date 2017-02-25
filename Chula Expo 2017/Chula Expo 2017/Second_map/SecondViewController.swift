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
    @IBOutlet var iconDescLabel: UILabel!
    @IBOutlet var descIcon: UIImageView!
    @IBOutlet var iconDescButton: UIView!
    
    @IBOutlet var currentView: UIView!
    @IBOutlet var currentViewLabel: UILabel!
    @IBOutlet var currentIcon: UIImageView!
    
    @IBOutlet var facultyIcon: UIView!
    @IBOutlet var favoriteIcon: UIView!
    @IBOutlet var canteenIcon: UIView!
    @IBOutlet var toiletIcon: UIView!
    @IBOutlet var prayerIcon: UIView!
    @IBOutlet var carParkIcon: UIView!
    
    @IBOutlet var facultyButton: UIView!
    @IBOutlet var favoriteButton: UIView!
    @IBOutlet var canteenButton: UIView!
    @IBOutlet var toiletButton: UIView!
    @IBOutlet var prayerButton: UIView!
    @IBOutlet var carParkButton: UIView!
    
    
    @IBOutlet var navigatorView: UIView!
    @IBOutlet var navigatorPin: UIImageView!
    @IBOutlet var facultyNameEn: UILabel!
    @IBOutlet var facultyNameTh: UILabel!
    @IBOutlet var navigatorCancel: UIButton!
    
    @IBOutlet var whereAmIView: UIView!
    @IBOutlet var whereAmILabel: UILabel!
    @IBOutlet var whereAmICancel: UIButton!
    @IBOutlet weak var eventAroundUser: UIButton!
    
    
    let managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var userLocation = CLLocation(latitude: 13.7387312, longitude: 100.5306979)
    
    var locationManager = CLLocationManager()
    var annotationLevel = 0
    var annotation = MKPointAnnotation()
    let annotationIcon = [
                            "PLACE": #imageLiteral(resourceName: "pin_landmark"),
                            "BUSSTOP": #imageLiteral(resourceName: "pin_cutour"),
                            "FAVORITED": #imageLiteral(resourceName: "pin_landmark"),
                            "RESERVED": #imageLiteral(resourceName: "pin_landmark"),
                            "CANTEEN": #imageLiteral(resourceName: "FOD-PIN"),
                            "TOILET": #imageLiteral(resourceName: "TOI-PIN"),
                            "CARPARK": #imageLiteral(resourceName: "LAN-PIN"),
                            "PRAYER": #imageLiteral(resourceName: "LAN-PIN"),
                            "EMERGENCY": #imageLiteral(resourceName: "LAN-PIN"),
                            "ENG": #imageLiteral(resourceName: "eng_pin_21"),
                            "ARTS": #imageLiteral(resourceName: "arts_pin_22"),
                            "SCI": #imageLiteral(resourceName: "sci_pin_23"),
                            "POLSCI": #imageLiteral(resourceName: "polsci_pin_24"),
                            "ARCH": #imageLiteral(resourceName: "arch_pin_25"),
                            "BANSHI": #imageLiteral(resourceName: "acc_pin_26"),
                            "EDU": #imageLiteral(resourceName: "edu_pin_27"),
                            "COMMARTS": #imageLiteral(resourceName: "commarts_pin_28"),
                            "ECON": #imageLiteral(resourceName: "econ_pin_29"),
                            "MED": #imageLiteral(resourceName: "med_pin_30"),
                            "VET": #imageLiteral(resourceName: "vet_pin_31"),
                            "DENT": #imageLiteral(resourceName: "dent_pin_32"),
                            "PHARM": #imageLiteral(resourceName: "pharm_pin_33"),
                            "LAW": #imageLiteral(resourceName: "law_pin_34"),
                            "FAA": #imageLiteral(resourceName: "faa_pin_35"),
                            "NUR": #imageLiteral(resourceName: "LAN-PIN"),
                            "AHS": #imageLiteral(resourceName: "ahs_pin_37"),
                            "PSY": #imageLiteral(resourceName: "psy_pin_38"),
                            "SPSC": #imageLiteral(resourceName: "spsc_pin_39"),
                            "CUSAR": #imageLiteral(resourceName: "cussar_pin_40"),
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
                            "INFO": #imageLiteral(resourceName: "pin_information")
    
    ]
    
    var zoneAnnotations = [MKPointAnnotation]()
    var placeAnnotations = [MKPointAnnotation]()
    var toiletAnnotations = [MKPointAnnotation]()
    var canteenAnnotations = [MKPointAnnotation]()
    var carParkAnnotations = [MKPointAnnotation]()
    var prayerAnnotations = [MKPointAnnotation]()
    var emergencyAnnotations = [MKPointAnnotation]()
    var favoritedAndReservedAnnotations = [MKPointAnnotation]()
    
    var favoritedActivity = [String: ActivityData]()
    var reservedActivity = [String: ActivityData]()
    
    var zoneID = [String: String]()
    var zoneTh = [String: String]()
    var zoneEn = [String: String]()
    var zoneLatitude = [String: CLLocationDegrees]()
    var zoneLongitude = [String: CLLocationDegrees]()
    
    var placeZone = [String: String]()
    var placeTh = [String: [String: String]!]()
    var placeEn = [String: [String: String]!]()
    var placeCode = [String: [String: String]!]()
    var placeLatitude = [String: [String: CLLocationDegrees]!]()
    var placeLongitude = [String: [String: CLLocationDegrees]!]()
    
    var facilityTh = [String: String]()
    var facilityEn = [String: String]()
    var facilityDescTh = [String: String]()
    var facilityDescEn = [String: String]()
    var facilityType = [String: String]()
    var facilityLatitude = [String: CLLocationDegrees]()
    var facilityLongitude = [String: CLLocationDegrees]()
    
    var isDescShowing = false
    var isCurrentShowing = false
    var isNavigatorShowing = false
    
    var isFacultyShowing = true
    var isFavoriteShowing = true
    var isCanteenShowing = true
    var isToiletShowing = true
    var isPrayerShowing = true
    var isCarParkShowing = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.setNeedsLayout()
    
        map.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        setCurrentRegion(lat: 13.7387312, lon: 100.5306979, latDelta: 0.01, lonDelta: 0.01)
    
        
        eventAroundUser.titleLabel?.adjustsFontSizeToFitWidth = true
        
        fetchZoneAnnotation()
        fetchFacilityAnnotation()
        addZoneAnnotation()
        addFacilityAnnotation()
        
        facultyIcon.layer.borderWidth = 3
        favoriteIcon.layer.borderWidth = 3
        toggleDescIconButton(toggleIcon: "canteen")
        toggleDescIconButton(toggleIcon: "toilet")
        toggleDescIconButton(toggleIcon: "prayer")
        toggleDescIconButton(toggleIcon: "carPark")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        addFavoritedAnnotation()
        addReservedAnnotation()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        map.removeAnnotations(favoritedAndReservedAnnotations)
        
        favoritedAndReservedAnnotations.removeAll()
        
    }
    
    private func setCurrentRegion(lat: CLLocationDegrees, lon: CLLocationDegrees, latDelta: CLLocationDegrees, lonDelta: CLLocationDegrees) {
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
    }

    override func viewDidLayoutSubviews() {
        
        let iconViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconDescButtonTapped(gestureRecognizer:)))
        iconDescButton.addGestureRecognizer(iconViewTapGesture)
        iconDescButton.isUserInteractionEnabled = true
        iconDescButton.layer.cornerRadius = iconDescButton.frame.height / 2
        
        iconDescView.layer.cornerRadius = iconDescView.frame.height / 2
        iconDescView.layer.shadowOffset = CGSize.zero
        iconDescView.layer.shadowColor = UIColor.black.cgColor
        iconDescView.layer.shadowOpacity = 0.3
        iconDescView.layer.shadowRadius = 2
        
        
        let currentViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.currentViewTapped(gestureRecognizer:)))
        currentView.addGestureRecognizer(currentViewTapGesture)
        currentView.isUserInteractionEnabled = true
        
        
        currentView.layer.cornerRadius = currentView.frame.height / 2
        currentView.layer.shadowOffset = CGSize.zero
        currentView.layer.shadowColor = UIColor.black.cgColor
        currentView.layer.shadowOpacity = 0.3
        currentView.layer.shadowRadius = 2
        
        let facultyTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconButtonTapped(gestureRecognizer:)))
        facultyButton.addGestureRecognizer(facultyTapGesture)
        facultyButton.isUserInteractionEnabled = true
        
        facultyIcon.layer.cornerRadius = facultyIcon.frame.height / 2
//        facultyIcon.layer.borderWidth = 3
        facultyIcon.layer.borderColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1).cgColor
        
        let favoriteTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconButtonTapped(gestureRecognizer:)))
        favoriteButton.addGestureRecognizer(favoriteTapGesture)
        favoriteButton.isUserInteractionEnabled = true
        
        favoriteIcon.layer.cornerRadius = favoriteIcon.frame.height / 2
//        favoriteIcon.layer.borderWidth = 3
        favoriteIcon.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
        
        let canteenTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconButtonTapped(gestureRecognizer:)))
        canteenButton.addGestureRecognizer(canteenTapGesture)
        canteenButton.isUserInteractionEnabled = true
        
        canteenIcon.layer.cornerRadius = canteenIcon.frame.height / 2
//        canteenIcon.layer.borderWidth = 3
        canteenIcon.layer.borderColor = UIColor(red: 0.584, green: 0.824, blue: 0, alpha: 1).cgColor
        
        let toiletTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconButtonTapped(gestureRecognizer:)))
        toiletButton.addGestureRecognizer(toiletTapGesture)
        toiletButton.isUserInteractionEnabled = true
        
        toiletIcon.layer.cornerRadius = toiletIcon.frame.height / 2
//        toiletIcon.layer.borderWidth = 3
        toiletIcon.layer.borderColor = UIColor(red: 0.22, green: 0.5725, blue: 0.878, alpha: 1).cgColor
        
        let prayerTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconButtonTapped(gestureRecognizer:)))
        prayerButton.addGestureRecognizer(prayerTapGesture)
        prayerButton.isUserInteractionEnabled = true
        
        prayerIcon.layer.cornerRadius = prayerIcon.frame.height / 2
//        prayerIcon.layer.borderWidth = 3
        prayerIcon.layer.borderColor = UIColor(red: 0, green: 0.79, blue: 0.725, alpha: 1).cgColor
        
        let carParkTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.iconButtonTapped(gestureRecognizer:)))
        carParkButton.addGestureRecognizer(carParkTapGesture)
        carParkButton.isUserInteractionEnabled = true
        
        carParkIcon.layer.cornerRadius = carParkIcon.frame.height / 2
//        carParkIcon.layer.borderWidth = 3
        carParkIcon.layer.borderColor = UIColor(red: 0, green: 0.376, blue: 0.725, alpha: 1).cgColor
        
        navigatorView.layer.cornerRadius = 10
        navigatorView.layer.shadowOffset = CGSize.zero
        navigatorView.layer.shadowColor = UIColor.black.cgColor
        navigatorView.layer.shadowOpacity = 0.3
        navigatorView.layer.shadowRadius = 2
        
        navigatorCancel.layer.cornerRadius = navigatorCancel.frame.height / 2
        navigatorCancel.layer.shadowOffset = CGSize.zero
        navigatorCancel.layer.shadowColor = UIColor.black.cgColor
        navigatorCancel.layer.shadowOpacity = 0.3
        navigatorCancel.layer.shadowRadius = 2
        
        whereAmIView.layer.cornerRadius = 10
        whereAmIView.layer.shadowOffset = CGSize.zero
        whereAmIView.layer.shadowColor = UIColor.black.cgColor
        whereAmIView.layer.shadowOpacity = 0.3
        whereAmIView.layer.shadowRadius = 2
        
        whereAmICancel.layer.cornerRadius = whereAmICancel.frame.height / 2
        whereAmICancel.layer.shadowOffset = CGSize.zero
        whereAmICancel.layer.shadowColor = UIColor.black.cgColor
        whereAmICancel.layer.shadowOpacity = 0.3
        whereAmICancel.layer.shadowRadius = 2
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations[0]
        
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
        
//        if annotationView == nil {
        
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView?.canShowCallout = true
            
            // Resize image
            
//            print("\(annotation.title!!) \(annotation.coordinate)")
            
            let pinImage = annotationIcon[annotation.title!!]
            
//            let size = CGSize(width: 33.67, height: 48.33)
//            UIGraphicsBeginImageContext(size)
//            pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
            
            
            annotationView?.image = pinImage
        
        if annotation.title!! == "TOILET" || annotation.title!! == "CANTEEN" {
            
            annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 23, height: 32)
            
        } else {
            
            annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 34, height: 48)
            
        }
            
            let rightButton = UIButton(type: UIButtonType.detailDisclosure)
            annotationView?.rightCalloutAccessoryView = rightButton
            
//        } else {
//            
//            annotationView?.annotation = annotation
//            
//        }
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let selectedAnnotation = view.annotation as? MKPointAnnotation
        
        if isDescShowing {
            
            iconDescButtonTapped(gestureRecognizer: UITapGestureRecognizer())
            
        }
        
        if selectedAnnotation?.subtitle == "ZONE" {
            
            if isFacultyShowing {
                
                toggleDescIconButton(toggleIcon: "faculty")
                
            }
    
            addPlaceAnnotation(forZone: (selectedAnnotation?.title)!)
            
            setCurrentRegion(lat: zoneLatitude[(selectedAnnotation?.title)!]!, lon: zoneLongitude[(selectedAnnotation?.title)!]!, latDelta: 0.003, lonDelta: 0.003)
         
            if isNavigatorShowing {
                
                navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
                facultyNameTh.text = zoneTh[(selectedAnnotation?.title)!]
                facultyNameEn.text = zoneEn[(selectedAnnotation?.title)!]
                
            } else {
                
                hideWherAmI(UIButton())
                
                annotationLevel += 1
                
                navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
                facultyNameTh.text = zoneTh[(selectedAnnotation?.title)!]
                facultyNameEn.text = zoneEn[(selectedAnnotation?.title)!]
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.navigatorView.isHidden = false
                    
                })
                
                isNavigatorShowing = true
                
            }
            
        } else if selectedAnnotation?.title == "PLACE" {
            
            let zoneName = placeZone[(selectedAnnotation?.subtitle)!]!
            
            navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
            facultyNameTh.text = placeTh[zoneName]?[(selectedAnnotation?.subtitle)!]
            facultyNameEn.text = placeEn[zoneName]?[(selectedAnnotation?.subtitle)!]
            
        } else {
            
            navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
            facultyNameTh.text = facilityTh[(selectedAnnotation?.subtitle)!]
            facultyNameEn.text = facilityEn[(selectedAnnotation?.subtitle)!]
            
        }
        
    }
    
    func iconDescButtonTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if isDescShowing {
            
            isDescShowing = !isDescShowing
            descIcon.image = #imageLiteral(resourceName: "list")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height: UIScreen.main.bounds.height * 0.059970015)
//                    self.view.bounds.height * 0.059970015)
                
                
                self.facultyButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.favoriteButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.canteenButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.toiletButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.prayerButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.carParkButton.transform = CGAffineTransform(translationX: 0, y: 0)
                
            })
            
        } else {
            
            isDescShowing = !isDescShowing
            descIcon.image = #imageLiteral(resourceName: "listPink")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height: UIScreen.main.bounds.height * 0.497751124)
                self.iconDescButton.frame = CGRect(x: self.iconDescButton.frame.origin.x, y: self.iconDescButton.frame.origin.y, width: self.iconDescButton.frame.width, height: UIScreen.main.bounds.height * 0.059970015)
//                    self.view.bounds.height * 0.497751124)
                
                self.facultyButton.transform = CGAffineTransform(translationX: 0, y: self.iconDescView.bounds.height * 0.120481928)
//                print(self.facultyButton.frame)
                self.favoriteButton.transform = CGAffineTransform(translationX: 0, y: self.iconDescView.bounds.height * 0.265060241)
                self.canteenButton.transform = CGAffineTransform(translationX: 0, y: self.iconDescView.bounds.height * 0.409638554)
                self.toiletButton.transform = CGAffineTransform(translationX: 0, y: self.iconDescView.bounds.height * 0.554216867)
                self.prayerButton.transform = CGAffineTransform(translationX: 0, y: self.iconDescView.bounds.height * 0.698795181)
                self.carParkButton.transform = CGAffineTransform(translationX: 0, y: self.iconDescView.bounds.height * 0.843373494)
               
            })
            
        }
        
    }
    
    func iconButtonTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if let iconView = gestureRecognizer.view {

            switch iconView {
                
            case facultyButton:
                
                toggleDescIconButton(toggleIcon: "faculty")
                
            case favoriteButton:
                
                toggleDescIconButton(toggleIcon: "favorited")
                
            case canteenButton:
                
                toggleDescIconButton(toggleIcon: "canteen")
                
            case toiletButton:
                
                toggleDescIconButton(toggleIcon: "toilet")
                
            case prayerButton:
                
                toggleDescIconButton(toggleIcon: "prayer")
                
            case carParkButton:
                
                toggleDescIconButton(toggleIcon: "carPark")
                
            default: break
                
            }
            
        }
        
        
    }
    
    func currentViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if isCurrentShowing {
            
            hideWherAmI(UIButton())
            
        } else {
            
            hideNavigator(UIButton())
            
            isCurrentShowing = !isCurrentShowing
            
            currentIcon.image = #imageLiteral(resourceName: "annotationPink")
            
            whereAmIView.isHidden = false
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.009, lonDelta: 0.009)
            
        }
        
    }
    
    private func toggleDescIconButton(toggleIcon: String) {
        
        switch toggleIcon {
            
        case "faculty":
            
            if isFacultyShowing {
                
                isFacultyShowing = false


                facultyIcon.layer.backgroundColor = UIColor.lightGray.cgColor
//                facultyIcon.layer.borderColor = UIColor.darkGray.cgColor
                facultyIcon.layer.borderWidth = 0
                
                map.removeAnnotations(zoneAnnotations)
                
            } else {
                
                isFacultyShowing = true
                
                facultyIcon.layer.backgroundColor = UIColor(red: 0.788235294, green: 0.22745098, blue: 0.22745098, alpha: 1).cgColor
//                facultyIcon.layer.borderColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1).cgColor
                facultyIcon.layer.borderWidth = 3
                
                map.addAnnotations(zoneAnnotations)
                
            }
            
        case "favorited":
            
            if isFavoriteShowing {
                
                isFavoriteShowing = false
                
                favoriteIcon.layer.backgroundColor = UIColor.lightGray.cgColor
//                favoriteIcon.layer.borderColor = UIColor.darkGray.cgColor
                favoriteIcon.layer.borderWidth = 0
                
                map.removeAnnotations(favoritedAndReservedAnnotations)
                
            } else {
                
                isFavoriteShowing = true
                
                favoriteIcon.layer.backgroundColor = UIColor(red: 1, green: 0.878431373, blue: 0.392156863, alpha: 1).cgColor
//                favoriteIcon.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
                favoriteIcon.layer.borderWidth = 3
                
                map.addAnnotations(favoritedAndReservedAnnotations)
                
            }
            
        case "canteen":
            
            if isCanteenShowing {
                
                isCanteenShowing = false
                
                canteenIcon.layer.backgroundColor = UIColor.lightGray.cgColor
//                canteenIcon.layer.borderColor = UIColor.darkGray.cgColor
                canteenIcon.layer.borderWidth = 0
                
                map.removeAnnotations(canteenAnnotations)
                
            } else {
                
                isCanteenShowing = true
                
                canteenIcon.layer.backgroundColor = UIColor(red: 0.654901961, green: 0.925490196, blue: 0, alpha: 1).cgColor
//                canteenIcon.layer.borderColor = UIColor(red: 0.584, green: 0.824, blue: 0, alpha: 1).cgColor
                canteenIcon.layer.borderWidth = 3
                
                
                map.addAnnotations(canteenAnnotations)
                
            }
            
        case "toilet":
            
            if isToiletShowing {
                
                isToiletShowing = false
                
                toiletIcon.layer.backgroundColor = UIColor.lightGray.cgColor
//                toiletIcon.layer.borderColor = UIColor.darkGray.cgColor
                toiletIcon.layer.borderWidth = 0
                
                map.removeAnnotations(toiletAnnotations)
                
            } else {
                
                isToiletShowing = true
                
                toiletIcon.layer.backgroundColor = UIColor(red: 0.37254902, green: 0.650980392, blue: 0.890196078, alpha: 1).cgColor
//                toiletIcon.layer.borderColor = UIColor(red: 0.22, green: 0.5725, blue: 0.878, alpha: 1).cgColor
                toiletIcon.layer.borderWidth = 3
                
                
                map.addAnnotations(toiletAnnotations)
                
            }
            
        case "prayer":
            
            if isPrayerShowing {
                
                isPrayerShowing = false
                
                prayerIcon.layer.backgroundColor = UIColor.lightGray.cgColor
//                prayerIcon.layer.borderColor = UIColor.darkGray.cgColor
                prayerIcon.layer.borderWidth = 0
                
                map.removeAnnotations(prayerAnnotations)
                
            } else {
                
                isPrayerShowing = true
                
                prayerIcon.layer.backgroundColor = UIColor(red: 0.066666667, green: 0.882352941, blue: 0.811764706, alpha: 1).cgColor
//                prayerIcon.layer.borderColor = UIColor(red: 0, green: 0.79, blue: 0.725, alpha: 1).cgColor
                prayerIcon.layer.borderWidth = 3
                
                
                map.addAnnotations(prayerAnnotations)
                
            }
            
        case "carPark":
            
            if isCarParkShowing {
                
                isCarParkShowing = false
                
                carParkIcon.layer.backgroundColor = UIColor.lightGray.cgColor
//                carParkIcon.layer.borderColor = UIColor.darkGray.cgColor
                carParkIcon.layer.borderWidth = 0
                
                
                map.removeAnnotations(carParkAnnotations)
                
            } else {
                
                isCarParkShowing = true
                
                carParkIcon.layer.backgroundColor = UIColor(red: 0.203921569, green: 0.494117647, blue: 0.764705882, alpha: 1).cgColor
//                carParkIcon.layer.borderColor = UIColor(red: 0, green: 0.376, blue: 0.725, alpha: 1).cgColor
                carParkIcon.layer.borderWidth = 3
                
                
                map.addAnnotations(carParkAnnotations)
                
            }
            
        default: break
            
        }
        
    }
    
    @IBAction func hideNavigator(_ sender: UIButton) {
        
        if isNavigatorShowing {
            
            if !isFacultyShowing {
                
                toggleDescIconButton(toggleIcon: "faculty")
                
            }
            
            map.removeAnnotations(placeAnnotations)
        
            navigatorView.isHidden = true
            
            isNavigatorShowing = false
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.009, lonDelta: 0.009)
            
        }
        
    }
    
    @IBAction func hideWherAmI(_ sender: UIButton) {
        
        if isCurrentShowing {
            
            currentIcon.image = #imageLiteral(resourceName: "annotation")
            
            whereAmIView.isHidden = true
            
            isCurrentShowing = false
            
        }
        
    }
    
    @IBAction func eventAroundUser(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toSearch", sender: self)
        
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
        
        zoneAnnotations.removeAll()
        
        for (key, _) in zoneEn {
            
            let zoneCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: zoneLatitude[key]!, longitude: zoneLongitude[key]!)
            
            let zoneAnnotation = MKPointAnnotation()
            zoneAnnotation.coordinate = zoneCoordinate
            zoneAnnotation.title = key
            zoneAnnotation.subtitle = "ZONE"
            
            zoneAnnotations.append(zoneAnnotation)
            map.addAnnotation(zoneAnnotation)
            
        }
        
    }
    
    func addPlaceAnnotation(forZone shortName: String) {
        
        placeAnnotations.removeAll()
        
        for (key, _) in placeEn[shortName] ?? [String: String]() {
            
            let placeCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: placeLatitude[shortName]![key]!, longitude: placeLongitude[shortName]![key]!)
            
            let placeAnnotation = MKPointAnnotation()
            placeAnnotation.coordinate = placeCoordinate
            placeAnnotation.title = "PLACE"
            placeAnnotation.subtitle = key
            
            placeAnnotations.append(placeAnnotation)
            map.addAnnotation(placeAnnotation)
            
        }
        
    }
    
    func addFacilityAnnotation() {
        
        toiletAnnotations.removeAll()
        canteenAnnotations.removeAll()
        carParkAnnotations.removeAll()
        prayerAnnotations.removeAll()
        emergencyAnnotations.removeAll()
        
        for (key, _) in facilityEn {
            
            let facilityCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: facilityLatitude[key]!, longitude: facilityLongitude[key]!)
            
            let facilityAnnotation = MKPointAnnotation()
            facilityAnnotation.coordinate = facilityCoordinate
//            print(facilityType[key]!.uppercased())
            facilityAnnotation.title = facilityType[key]!.uppercased()
            facilityAnnotation.subtitle = key
            
            switch facilityAnnotation.title! {
            case "TOILET":
                
                toiletAnnotations.append(facilityAnnotation)
                
            case "CANTEEN":
                
                canteenAnnotations.append(facilityAnnotation)
                
            case "CARPARK":
                
                carParkAnnotations.append(facilityAnnotation)
                
            case "PRAYER":
                
                prayerAnnotations.append(facilityAnnotation)
                
            case "EMERGENCY":
                
                emergencyAnnotations.append(facilityAnnotation)
                
            default: break
                
            }
            
                
            
            
            map.addAnnotation(facilityAnnotation)
            
        }
        
        
    }
    
    func addFavoritedAnnotation() {
        
        let favoritedDatas = FavoritedActivity.fetchFavoritedActivity(inManageobjectcontext: managedObjectContext!)!
//        print("Add Favorited")
        for favoritedData in favoritedDatas {
//            print(favoritedData.activityId)
//            print(favoritedData.toActivity?.name)
            let favoritedCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (favoritedData.toActivity?.latitude)!, longitude: (favoritedData.toActivity?.longitude)!)
            
            let favoritedAnnotation = MKPointAnnotation()
            favoritedAnnotation.coordinate = favoritedCoordinate
            favoritedAnnotation.title = "FAVORITED"
            favoritedAnnotation.subtitle = favoritedData.activityId
            
            favoritedActivity.updateValue(favoritedData.toActivity!, forKey: favoritedData.activityId!)
            
            favoritedAndReservedAnnotations.append(favoritedAnnotation)
            
            map.addAnnotation(favoritedAnnotation)
            
        }
        
    }
    
    func addReservedAnnotation() {
        
        let reservedDatas = ReservedActivity.fetchReservedActivity(inManageobjectcontext: managedObjectContext!)!
        print("Add Reserved")
        print(reservedDatas.count)
        for reservedData in reservedDatas {
            print(reservedData.activityId)
            print(reservedData.toActivity?.name)
            let reservedCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (reservedData.toActivity?.latitude)!, longitude: (reservedData.toActivity?.longitude)!)
            
            let reservedAnnotation = MKPointAnnotation()
            reservedAnnotation.coordinate = reservedCoordinate
            reservedAnnotation.title = "RESERVED"
            reservedAnnotation.subtitle = reservedData.activityId
            
            reservedActivity.updateValue(reservedData.toActivity!, forKey: reservedData.activityId!)
            
            favoritedAndReservedAnnotations.append(reservedAnnotation)
            
            map.addAnnotation(reservedAnnotation)
            
        }
        
    }
    
    func fetchZoneAnnotation() {
        
        let zoneLocations = ZoneData.fetchZoneLocation(inManageobjectcontext: managedObjectContext!)
        
        for zoneLocation in zoneLocations! {
            
            zoneID.updateValue(zoneLocation["id"]!, forKey: zoneLocation["shortName"]!)
            zoneEn.updateValue(zoneLocation["nameEn"]!, forKey: zoneLocation["shortName"]!)
            zoneTh.updateValue(zoneLocation["nameTh"]!, forKey: zoneLocation["shortName"]!)
            zoneLatitude.updateValue(Double(zoneLocation["latitude"]!)!, forKey: zoneLocation["shortName"]!)
            zoneLongitude.updateValue(Double(zoneLocation["longitude"]!)!, forKey: zoneLocation["shortName"]!)
            
            placeTh[zoneLocation["shortName"]!] = [String: String]()
            placeEn[zoneLocation["shortName"]!] = [String: String]()
            placeCode[zoneLocation["shortName"]!] = [String: String]()
            placeLatitude[zoneLocation["shortName"]!] = [String: CLLocationDegrees]()
            placeLongitude[zoneLocation["shortName"]!] = [String: CLLocationDegrees]()
            
            fetchPlaceAnnotation(forZone: zoneLocation["id"]!, shortName: zoneLocation["shortName"]!)
            
        }
        
        
    }
    
    func fetchPlaceAnnotation(forZone id: String, shortName: String) {
        
        let placeLocations = ZoneData.fetchPlace(InZone: id, inManageobjectcontext: managedObjectContext!)
        
        for placeLocation in placeLocations! {

            placeZone[placeLocation["id"]!] = shortName
            placeTh[shortName]?.updateValue(placeLocation["nameTh"]!, forKey: placeLocation["id"]!)
            placeEn[shortName]?.updateValue(placeLocation["nameEn"]!, forKey: placeLocation["id"]!)
            placeCode[shortName]?.updateValue(placeLocation["code"]!, forKey: placeLocation["id"]!)
            placeLatitude[shortName]?.updateValue(Double(placeLocation["latitude"]!)!, forKey: placeLocation["id"]!)
            placeLongitude[shortName]?.updateValue(Double(placeLocation["longitude"]!)!, forKey: placeLocation["id"]!)
            
        }
        
    }
    
    private func fetchFacilityAnnotation() {
        
//        let facilityLocations = PlaceData.fetchFacility(InPlace: id, inManageobjectcontext: managedObjectContext!)
        
        let facilityLocations = FacilityData.fetchFacility(inManageobjectcontext: managedObjectContext!)
        
        for facilityLocation in facilityLocations! {
            
            facilityTh.updateValue(facilityLocation["nameTh"]!, forKey: facilityLocation["id"]!)
            facilityEn.updateValue(facilityLocation["nameEn"]!, forKey: facilityLocation["id"]!)
            facilityDescTh.updateValue(facilityLocation["descTh"]!, forKey: facilityLocation["id"]!)
            facilityDescEn.updateValue(facilityLocation["descEn"]!, forKey:facilityLocation["id"]!)
            facilityType.updateValue(facilityLocation["type"]!, forKey: facilityLocation["id"]!)
            facilityLatitude.updateValue(Double(facilityLocation["latitude"]!)!, forKey: facilityLocation["id"]!)
            facilityLongitude.updateValue(Double(facilityLocation["longitude"]!)!, forKey: facilityLocation["id"]!)
            
        }
        
    }

}
