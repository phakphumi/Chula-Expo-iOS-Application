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

class SecondViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet var iconDescView: UIView!
    @IBOutlet var iconDescLabel: UILabel!
    @IBOutlet var descIcon: UIImageView!
    @IBOutlet var iconDescButton: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var currentView: UIView!
    @IBOutlet var currentViewLabel: UILabel!
    @IBOutlet var currentIcon: UIImageView!
    
    @IBOutlet var navigatorView: UIView!
    @IBOutlet var navigatorPin: UIImageView!
    @IBOutlet var facultyNameEn: UILabel!
    @IBOutlet var facultyNameTh: UILabel!
    @IBOutlet var navigatorCancel: UIButton!
    
    @IBOutlet var whereAmIView: UIView!
    @IBOutlet var whereAmILabel: UILabel!
    @IBOutlet var whereAmICancel: UIButton!
    @IBOutlet weak var eventAroundUser: UIButton!
    
    @IBOutlet weak var myActivityView: UIView!
    @IBOutlet weak var myActivityName: UILabel!
    @IBOutlet weak var myActivityCancel: UIButton!
    @IBOutlet weak var myActivityDetail: UIButton!
    
    
    let managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var userLocation = CLLocation(latitude: 13.7387312, longitude: 100.5306979)
    
    var locationManager = CLLocationManager()
    var annotationLevel = 0
    var annotation = MKPointAnnotation()
    let annotationIcon = [
                            "PLACE": #imageLiteral(resourceName: "pin_landmark"),
                            "BUSSTOP": #imageLiteral(resourceName: "pin_cutour"),
                            "FAVORITEDANDRESERVED": #imageLiteral(resourceName: "pin_landmark"),
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
                            "SAR": #imageLiteral(resourceName: "cussar_pin_40"),
                            "GRAD": #imageLiteral(resourceName: "LAN-PIN"),
                            "SMART": #imageLiteral(resourceName: "SMART-PIN"),
                            "HEALTH": #imageLiteral(resourceName: "LAN-PIN"),
                            "HUMAN": #imageLiteral(resourceName: "LAN-PIN"),
                            "ART": #imageLiteral(resourceName: "LAN-PIN"),
                            "CENSTAGE": #imageLiteral(resourceName: "GRAND AUDIT"),
                            "HALL": #imageLiteral(resourceName: "LAN-PIN"),
                            "SALA": #imageLiteral(resourceName: "SALA"),
                            "INTERFORUM": #imageLiteral(resourceName: "LAN-PIN"),
                            "MARKET": #imageLiteral(resourceName: "LAN-PIN"),
                            "INFO": #imageLiteral(resourceName: "pin_information"),
                            "INFORMATION": #imageLiteral(resourceName: "pin_information"),
                            "REGISTRATION": #imageLiteral(resourceName: "LAN-PIN"),
                            "RALLY": #imageLiteral(resourceName: "LAN-PIN")
    
    ]
    
    var placeAnnotations = [MKPointAnnotation]()
    var zoneAnnotations = [MKPointAnnotation]()
    var favoritedAndReservedAnnotations = [MKPointAnnotation]()
    var canteenAnnotations = [MKPointAnnotation]()
    var registrationAnnotations = [MKPointAnnotation]()
    var informationAnnotations = [MKPointAnnotation]()
    var toiletAnnotations = [MKPointAnnotation]()
    var rallyAnnotations = [MKPointAnnotation]()
    var carParkAnnotations = [MKPointAnnotation]()
    var prayerAnnotations = [MKPointAnnotation]()
    var emergencyAnnotations = [MKPointAnnotation]()
    
//    var favoritedActivity = [String: ActivityData]()
//    var reservedActivity = [String: ActivityData]()
    
    var showingMyActivity = ActivityData()
    var favoritedAndReservedActivity = [String: ActivityData]()
    
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
    var isMyActivityShowing = false
    
    var isFacultyShowing = true
    var isFavoriteShowing = true
    var isCanteenShowing = false
    var isRegistrationShowing = false
    var isInformationShowing = false
    var isToiletShowing = false
    var isRallyShowing = false
    var isCarParkShowing = false
    var isEmergencyShowing = false
    var isPrayerShowing = false
    
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
        myActivityDetail.titleLabel?.adjustsFontSizeToFitWidth = true
        
        fetchZoneAnnotation()
        fetchFacilityAnnotation()
        addZoneAnnotation()
        addFacilityAnnotation()
        
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
        
        tableView.layer.cornerRadius = iconDescView.frame.height / 2
        
        self.tableView.frame = CGRect(x: 0, y: self.iconDescView.frame.width * 4 / 17, width: self.iconDescView.frame.width, height: 0)
        
        
        let currentViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.currentViewTapped(gestureRecognizer:)))
        currentView.addGestureRecognizer(currentViewTapGesture)
        currentView.isUserInteractionEnabled = true
        
        
        currentView.layer.cornerRadius = currentView.frame.height / 2
        currentView.layer.shadowOffset = CGSize.zero
        currentView.layer.shadowColor = UIColor.black.cgColor
        currentView.layer.shadowOpacity = 0.3
        currentView.layer.shadowRadius = 2
        
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
        
        myActivityView.layer.cornerRadius = 10
        myActivityView.layer.shadowOffset = CGSize.zero
        myActivityView.layer.shadowColor = UIColor.black.cgColor
        myActivityView.layer.shadowOpacity = 0.3
        myActivityView.layer.shadowRadius = 2
        
        myActivityCancel.layer.cornerRadius = whereAmICancel.frame.height / 2
        myActivityCancel.layer.shadowOffset = CGSize.zero
        myActivityCancel.layer.shadowColor = UIColor.black.cgColor
        myActivityCancel.layer.shadowOpacity = 0.3
        myActivityCancel.layer.shadowRadius = 2
        
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
        
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        
        let pinImage = annotationIcon[annotation.title!!]
        
        
        
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
                
            map.removeAnnotations(zoneAnnotations)
    
            addPlaceAnnotation(forZone: (selectedAnnotation?.title)!)
            
            setCurrentRegion(lat: zoneLatitude[(selectedAnnotation?.title)!]!, lon: zoneLongitude[(selectedAnnotation?.title)!]!, latDelta: 0.003, lonDelta: 0.003)
         
            if isNavigatorShowing {
                
                navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
                facultyNameTh.text = zoneTh[(selectedAnnotation?.title)!]
                facultyNameEn.text = zoneEn[(selectedAnnotation?.title)!]
                
            } else {
                
                hideWherAmI(UIButton())
                hideMyActivity(UIButton())
                
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
            
        } else if selectedAnnotation?.title == "FAVORITEDANDRESERVED"{
         
            showingMyActivity = favoritedAndReservedActivity[(selectedAnnotation?.subtitle)!]!
            
            if isMyActivityShowing {
                
                myActivityName.text = showingMyActivity.name
                
            } else {
                
                hideWherAmI(UIButton())
                hideNavigator(UIButton())
                
                
                myActivityName.text = showingMyActivity.name
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.myActivityView.isHidden = false
                    
                })
                
                isMyActivityShowing = true
                
            }
            
            
            
        }else {
            
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
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height: self.iconDescView.frame.width * 4 / 17)
                
                self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.iconDescView.frame.width * 4 / 17, width: self.tableView.frame.width, height: 0)
                
            })
            
        } else {
            
            isDescShowing = !isDescShowing
            descIcon.image = #imageLiteral(resourceName: "listPink")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height:  UIScreen.main.bounds.height * 0.554722639)
                
                self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.iconDescView.frame.width * 4 / 17, width: self.tableView.frame.width, height: UIScreen.main.bounds.height * 0.475)
               
            })
            
        }
        
    }
    
    func currentViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if isCurrentShowing {
            
            hideWherAmI(UIButton())
            
        } else {
            
            hideNavigator(UIButton())
            hideMyActivity(UIButton())
            
            isCurrentShowing = !isCurrentShowing
            
            currentIcon.image = #imageLiteral(resourceName: "annotationPink")
            
            whereAmIView.isHidden = false
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.009, lonDelta: 0.009)
            
        }
        
    }
    
    @IBAction func hideMyActivity(_ sender: UIButton) {
        
        if isMyActivityShowing {
            
            myActivityView.isHidden = true
            
            isMyActivityShowing = false
            
        }
        
    }
    
    @IBAction func hideNavigator(_ sender: UIButton) {
        
        if isNavigatorShowing {
            
            map.addAnnotations(zoneAnnotations)
            
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
    
    @IBAction func myActivityDetail(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toEventDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEventDetail" {
            
            if let destination = segue.destination as? EventDetailTableViewController {
                
                destination.activityId = showingMyActivity.activityId
                destination.bannerUrl = showingMyActivity.bannerUrl
                destination.topic = showingMyActivity.name
                destination.locationDesc = ""
                destination.toRounds = showingMyActivity.toRound
                destination.desc = showingMyActivity.desc
                destination.room = showingMyActivity.room
                destination.place = showingMyActivity.place
                destination.zoneId = showingMyActivity.faculty
                destination.latitude = showingMyActivity.latitude
                destination.longitude = showingMyActivity.longitude
                destination.pdf = showingMyActivity.pdf
                destination.toImages = showingMyActivity.toImages
                destination.toTags = showingMyActivity.toTags
                destination.managedObjectContext = self.managedObjectContext
                
            }
            
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
        
        canteenAnnotations.removeAll()
        registrationAnnotations.removeAll()
        informationAnnotations.removeAll()
        toiletAnnotations.removeAll()
        rallyAnnotations.removeAll()
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
                
            case "CANTEEN":
                
                canteenAnnotations.append(facilityAnnotation)
                
            case "REGISTRATION":
                
                registrationAnnotations.append(facilityAnnotation)
                
            case "INFORMATION":
                
                informationAnnotations.append(facilityAnnotation)
                
            case "TOILET":
                
                toiletAnnotations.append(facilityAnnotation)
                
            case "RALLY":
                
                rallyAnnotations.append(facilityAnnotation)
                
            case "CARPARK":
                
                carParkAnnotations.append(facilityAnnotation)
                
            case "PRAYER":
                
                prayerAnnotations.append(facilityAnnotation)
                
            case "EMERGENCY":
                
                emergencyAnnotations.append(facilityAnnotation)
                
            default: break
                
            }
            
//            map.addAnnotation(facilityAnnotation)
            
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
            favoritedAnnotation.title = "FAVORITEDANDRESERVED"
            favoritedAnnotation.subtitle = favoritedData.activityId
            
            favoritedAndReservedActivity.updateValue(favoritedData.toActivity!, forKey: favoritedData.activityId!)
            
            favoritedAndReservedAnnotations.append(favoritedAnnotation)
            
            map.addAnnotation(favoritedAnnotation)
            
        }
        
    }
    
    func addReservedAnnotation() {
        
        let reservedDatas = ReservedActivity.fetchReservedActivity(inManageobjectcontext: managedObjectContext!)!
        
        for reservedData in reservedDatas {
            
            let reservedCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (reservedData.toActivity?.latitude)!, longitude: (reservedData.toActivity?.longitude)!)
            
            let reservedAnnotation = MKPointAnnotation()
            reservedAnnotation.coordinate = reservedCoordinate
            reservedAnnotation.title = "FAVORITEDANDRESERVED"
            reservedAnnotation.subtitle = reservedData.activityId
            
            favoritedAndReservedActivity.updateValue(reservedData.toActivity!, forKey: reservedData.activityId!)
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconDescCell")
        
        if let idtv = cell as? IconDescTableViewCell {
            
            idtv.frame = CGRect(x: idtv.frame.origin.x, y: idtv.frame.origin.y, width: UIScreen.main.bounds.width * 0.453333333, height: idtv.frame.height)
            
            if indexPath.row == 0 {
                
                idtv.iconView.layer.backgroundColor = UIColor(red: 0.788235294, green: 0.22745098, blue: 0.22745098, alpha: 1).cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 3
                idtv.iconImage.image = #imageLiteral(resourceName: "students-cap")
                idtv.descTh.text = "คณะ/เมือง"
                idtv.descEn.text = "Faculty/Zone"
                
            } else if indexPath.row == 1 {
                
                idtv.iconView.layer.backgroundColor = UIColor(red: 1, green: 0.878431373, blue: 0.392156863, alpha: 1).cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 3
                idtv.iconImage.image = #imageLiteral(resourceName: "ico-star")
                idtv.descTh.text = "กิจกรรมของฉัน"
                idtv.descEn.text = "My Event"
                
            } else if indexPath.row == 2 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 0.584, green: 0.824, blue: 0, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "canteen")
                idtv.descTh.text = "ร้านค้า/อาหาร"
                idtv.descEn.text = "Shop/Food"
                
                map.removeAnnotations(canteenAnnotations)
                
            } else if indexPath.row == 3 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "id-card")
                idtv.descTh.text = "จุดลงทะเบียน"
                idtv.descEn.text = "Registration"
                
            } else if indexPath.row == 4 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "info")
                idtv.descTh.text = "จุดประชาสัมพันธ์"
                idtv.descEn.text = "Information"
                
            } else if indexPath.row == 5 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 0.22, green: 0.5725, blue: 0.878, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "toilet")
                idtv.descTh.text = "ห้องน้ำ"
                idtv.descEn.text = "Toilet"
                
            } else if indexPath.row == 6 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "checkered-flag")
                idtv.descTh.text = "กิจกรรมแรลลี่"
                idtv.descEn.text = "Rally"
                
            } else if indexPath.row == 7 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 0, green: 0.376, blue: 0.725, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "car")
                idtv.descTh.text = "ที่จอดรถ"
                idtv.descEn.text = "Car Park"
                
            } else if indexPath.row == 8 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 0, green: 0.79, blue: 0.725, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "first-aid-kit")
                idtv.descTh.text = "จุดปฐมพยาบาล"
                idtv.descEn.text = "EMERGENCY"
                
            } else if indexPath.row == 9 {
                
                idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                idtv.iconView.layer.borderColor = UIColor(red: 0, green: 0.79, blue: 0.725, alpha: 1).cgColor
                idtv.iconView.layer.borderWidth = 0
                idtv.iconImage.image = #imageLiteral(resourceName: "prayer")
                idtv.descTh.text = "ห้องละหมาด"
                idtv.descEn.text = "Prayer"
                
            }
            
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if let idtv = cell as? IconDescTableViewCell {
         
            if indexPath.row == 0 {
                
                if isNavigatorShowing {
                    
                    
                    
                } else if isFacultyShowing {
                    
                    isFacultyShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: zoneAnnotations)
                    
                } else {
                    
                    isFacultyShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: zoneAnnotations, bgColor: UIColor(red: 0.788235294, green: 0.22745098, blue: 0.22745098, alpha: 1).cgColor)
                    
                }
                
            } else if indexPath.row == 1 {
                
                if isFavoriteShowing {
                    
                    isFavoriteShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: favoritedAndReservedAnnotations)
                    
                } else {
                    
                    isFavoriteShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: favoritedAndReservedAnnotations, bgColor: UIColor(red: 1, green: 0.878431373, blue: 0.392156863, alpha: 1).cgColor)
                    
                }
                
            } else if indexPath.row == 2 {
                
                if isCanteenShowing {
                    
                    isCanteenShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: canteenAnnotations)
                    
                } else {
                    
                    isCanteenShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: canteenAnnotations, bgColor: UIColor(red: 0.654901961, green: 0.925490196, blue: 0, alpha: 1).cgColor)
                    
                }
                
            } else if indexPath.row == 3 {
                
                if isRegistrationShowing {
                    
                    isRegistrationShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: registrationAnnotations)
                    
                } else {
                    
                    isRegistrationShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: registrationAnnotations, bgColor: UIColor.brown.cgColor)
                    
                }
                
                
                
            } else if indexPath.row == 4 {
                
                if isInformationShowing {
                    
                    isInformationShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: informationAnnotations)
                    
                } else {
                    
                    isInformationShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: informationAnnotations, bgColor: UIColor.green.cgColor)
                    
                }
                
            } else if indexPath.row == 5 {
                
                if isToiletShowing {
                    
                    isToiletShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: toiletAnnotations)
                    
                } else {
                    
                    isToiletShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: toiletAnnotations, bgColor: UIColor(red: 0.37254902, green: 0.650980392, blue: 0.890196078, alpha: 1).cgColor)
                    
                }
                
            } else if indexPath.row == 6 {
                
                if isRallyShowing {
                    
                    isRallyShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: rallyAnnotations)
                    
                } else {
                    
                    isRallyShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: rallyAnnotations, bgColor: UIColor.purple.cgColor)
                    
                }
                
            } else if indexPath.row == 7 {
                
                if isCarParkShowing {
                    
                    isCarParkShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: carParkAnnotations)
                    
                } else {
                    
                    isCarParkShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: carParkAnnotations, bgColor: UIColor(red: 0.203921569, green: 0.494117647, blue: 0.764705882, alpha: 1).cgColor)
                    
                }
                
                
            } else if indexPath.row == 8 {
                
                if isEmergencyShowing {
                    
                    isEmergencyShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: emergencyAnnotations)
                    
                } else {
                    
                    isEmergencyShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: emergencyAnnotations, bgColor: UIColor.red.cgColor)
                    
                }

            } else if indexPath.row == 9 {
                
                if isPrayerShowing {
                    
                    isPrayerShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: prayerAnnotations)
                    
                } else {
                    
                    isPrayerShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: prayerAnnotations, bgColor: UIColor(red: 0.066666667, green: 0.882352941, blue: 0.811764706, alpha: 1).cgColor)
                    
                }
                
            }
            
        }
        
    }
    
    private func turnIconOff(forCell cell: IconDescTableViewCell, annotations: [MKAnnotation]) {
        
        cell.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        cell.iconView.layer.borderWidth = 0
        
        map.removeAnnotations(annotations)
        
    }
    
    private func turnIconOn(forCell cell: IconDescTableViewCell, annotations: [MKAnnotation], bgColor: CGColor) {
        
        cell.iconView.layer.backgroundColor = bgColor
        
        cell.iconView.layer.borderWidth = 3
        
        map.addAnnotations(annotations)
        
    }

}
