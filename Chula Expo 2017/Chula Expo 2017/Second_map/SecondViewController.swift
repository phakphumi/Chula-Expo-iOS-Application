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
import CoreLocation

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
    
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var placePin: UIImageView!
    @IBOutlet weak var placeTH: UILabel!
    @IBOutlet weak var placeEN: UILabel!
    @IBOutlet weak var placeCancel: UIButton!
    
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
    
//    var annotation = MKPointAnnotation()
    let annotationIcon = [
                            "ENG": #imageLiteral(resourceName: "PIN-ENG"),
                            "ENG-PLACE": #imageLiteral(resourceName: "PLACE-ENG"),
                            "MED": #imageLiteral(resourceName: "PIN-MED"),
                            "MED-PLACE": #imageLiteral(resourceName: "PLACE-MED"),
                            "SCI": #imageLiteral(resourceName: "PIN-SCI"),
                            "SCI-PLACE": #imageLiteral(resourceName: "PLACE-SCI"),
                            "BANSHI": #imageLiteral(resourceName: "PIN-BANSHI"),
                            "BANSHI-PLACE": #imageLiteral(resourceName: "PLACE-BANSHI"),
                            "POLSCI": #imageLiteral(resourceName: "PIN-POLSCI"),
                            "POLSCI-PLACE": #imageLiteral(resourceName: "PLACE-POLSCI"),
                            "EDU": #imageLiteral(resourceName: "PIN-EDU"),
                            "EDU-PLACE": #imageLiteral(resourceName: "PLACE-EDU"),
                            "PSY": #imageLiteral(resourceName: "PIN-PSY"),
                            "PSY-PLACE": #imageLiteral(resourceName: "PLACE-PSY"),
                            "DENT": #imageLiteral(resourceName: "PIN-DENT"),
                            "DENT-PLACE": #imageLiteral(resourceName: "PLACE-DENT"),
                            "LAW": #imageLiteral(resourceName: "PIN-LAW"),
                            "LAW-PLACE": #imageLiteral(resourceName: "PLACE-LAW"),
                            "COMMARTS": #imageLiteral(resourceName: "PIN-COMMARTS"),
                            "COMMARTS-PLACE": #imageLiteral(resourceName: "PLACE-COMMARTS"),
                            "NUR": #imageLiteral(resourceName: "PIN-NUR"),
                            "NUR-PLACE": #imageLiteral(resourceName: "PLACE-NUR"),
                            "SPSC": #imageLiteral(resourceName: "PIN-SPSC"),
                            "SPSC-PLACE": #imageLiteral(resourceName: "PLACE-SPSC"),
                            "FAA": #imageLiteral(resourceName: "PIN-FAA"),
                            "FAA-PLACE": #imageLiteral(resourceName: "PLACE-FAA"),
                            "ARCH": #imageLiteral(resourceName: "PIN-ARCH"),
                            "ARCH-PLACE": #imageLiteral(resourceName: "PLACE-ARCH"),
                            "AHS": #imageLiteral(resourceName: "PIN-AHS"),
                            "AHS-PLACE": #imageLiteral(resourceName: "PLACE-AHS"),
                            "VET": #imageLiteral(resourceName: "PIN-VET"),
                            "VET-PLACE": #imageLiteral(resourceName: "PLACE-VET"),
                            "ARTS": #imageLiteral(resourceName: "PIN-ARTS"),
                            "ARTS-PLACE": #imageLiteral(resourceName: "PLACE-ARTS"),
                            "PHARM": #imageLiteral(resourceName: "PIN-PHARM"),
                            "PHARM-PLACE": #imageLiteral(resourceName: "PLACE-PHARM"),
                            "ECON": #imageLiteral(resourceName: "PIN-ECON"),
                            "ECON-PLACE": #imageLiteral(resourceName: "PLACE-ECON"),
                            "SAR": #imageLiteral(resourceName: "PIN-SAR"),
                            "SAR-PLACE": #imageLiteral(resourceName: "PLACE-SAR"),
                            "GRAD": #imageLiteral(resourceName: "PIN-GRAD"),
                            "GRAD-PLACE": #imageLiteral(resourceName: "PLACE-GRAD"),
                            "SMART": #imageLiteral(resourceName: "CTY-SMART"),
                            "SMART-PLACE": #imageLiteral(resourceName: "PLACE-SMART"),
                            "HEALTH": #imageLiteral(resourceName: "CTY-HEALTH"),
                            "HEALTH-PLACE": #imageLiteral(resourceName: "PLACE-HEALTH"),
                            "HUMAN": #imageLiteral(resourceName: "CTY-HUMAN"),
                            "HUMAN-PLACE": #imageLiteral(resourceName: "PLACE-HUMAN"),
                            "ART": #imageLiteral(resourceName: "CTY-ARTGAL"),
                            "ART-PLACE": #imageLiteral(resourceName: "PLACE-ARTGAL"),
                            "CENSTAGE": #imageLiteral(resourceName: "CTY-CENSTAGE"),
                            "CENSTAGE-PLACE": #imageLiteral(resourceName: "PLACE-CENSTAGE"),
                            "HALL": #imageLiteral(resourceName: "CTY-CUTALK"),
                            "HALL-PLACE": #imageLiteral(resourceName: "PLACE-CUTALK"),
                            "SALA": #imageLiteral(resourceName: "CTY-CU100"),
                            "SALA-PLACE": #imageLiteral(resourceName: "PLACE-CU100"),
                            "INTERFORUM": #imageLiteral(resourceName: "CTY-FORUM"),
                            "INTERFORUM-PLACE": #imageLiteral(resourceName: "PLACE-FORUM"),
                            "MARKET": #imageLiteral(resourceName: "SHOP"),
                            "MARKET-PLACE": #imageLiteral(resourceName: "SHOP"),
                            "RALLY": #imageLiteral(resourceName: "RALLY"),
                            "RALLY-PLACE": #imageLiteral(resourceName: "RALLY"),
                            "TOILET": #imageLiteral(resourceName: "TOILET"),
                            "CANTEEN": #imageLiteral(resourceName: "FOOD"),
                            "CARPARK": #imageLiteral(resourceName: "PARK"),
                            "PRAYER": #imageLiteral(resourceName: "PRAY"),
                            "EMERGENCY": #imageLiteral(resourceName: "AID"),
                            "INFORMATION": #imageLiteral(resourceName: "INFO"),
                            "REGISTRATION": #imageLiteral(resourceName: "REGIS"),
                            "BUSSTOP": #imageLiteral(resourceName: "BUS"),
                            "FAVORITEDANDRESERVED": #imageLiteral(resourceName: "RES"),
//                            "INFO": #imageLiteral(resourceName: "pin_information"),
    
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
    
    static var showingMyActivity = ActivityData()
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
    var isPlaceShowing = false
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
        
        placeView.layer.cornerRadius = 10
        placeView.layer.shadowOffset = CGSize.zero
        placeView.layer.shadowColor = UIColor.black.cgColor
        placeView.layer.shadowOpacity = 0.3
        placeView.layer.shadowRadius = 2
        
        placeCancel.layer.cornerRadius = placeCancel.frame.height / 2
        placeCancel.layer.shadowOffset = CGSize.zero
        placeCancel.layer.shadowColor = UIColor.black.cgColor
        placeCancel.layer.shadowOpacity = 0.3
        placeCancel.layer.shadowRadius = 2
        
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
        
//        userLocation = locations[0]
//        
//        map.removeAnnotation(annotation)
//        
//        annotation.coordinate = userLocation.coordinate
//        
//        map.addAnnotation(annotation)
        
        APIController.getWhereAmI(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude, inManageobjectcontext: managedObjectContext!, completion: { (zone) in
            
            self.map.userLocation.title = "คุณอยู่ที่\(zone?["th"] ?? "\'ไม่พบข้อมูล\'")"
            
        })
        
        map.showsUserLocation = true
        
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
        annotationView?.contentMode = .scaleAspectFit
        
        if annotation.title!! == "TOILET" || annotation.title!! == "CANTEEN" || annotation.title!! == "CARPARK" || annotation.title!! == "INFORMATION" || annotation.title!! == "REGISTRATION" || annotation.title!! == "EMERGENCY" || annotation.title!! == "PRAYER" || annotation.title!! == "MARKET" || annotation.title!! == "BUSSTOP" || annotation.title!! == "RALLY" {
            
            annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 29.6, height: 38.78)
            
        } else {
            
            annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 37, height: 54)
            
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
        
        if view.annotation is MKUserLocation {
            
            
        } else {
            
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
                    hidePlace(UIButton())
                    
                    navigatorPin.image = annotationIcon[(selectedAnnotation?.title)!]
                    facultyNameTh.text = zoneTh[(selectedAnnotation?.title)!]
                    facultyNameEn.text = zoneEn[(selectedAnnotation?.title)!]
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.navigatorCancel.isHidden = false
                        self.navigatorView.isHidden = false
                        
                    })
                    
                    isNavigatorShowing = true
                    
                }
                
            } else if selectedAnnotation?.title == "FAVORITEDANDRESERVED"{
                
                SecondViewController.showingMyActivity = favoritedAndReservedActivity[(selectedAnnotation?.subtitle)!]!
                
                if isMyActivityShowing {
                    
                    myActivityName.text = SecondViewController.showingMyActivity.name
                    
                } else {
                    
                    hideWherAmI(UIButton())
                    hideNavigator(UIButton())
                    hidePlace(UIButton())
                    
                    
                    myActivityName.text = SecondViewController.showingMyActivity.name
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.myActivityCancel.isHidden = false
                        self.myActivityView.isHidden = false
                        
                    })
                    
                    isMyActivityShowing = true
                    
                }
                
                
                
            } else if (selectedAnnotation?.title?.contains("PLACE"))! {
                
                let zoneName = placeZone[(selectedAnnotation?.subtitle)!]!
                
                if isPlaceShowing {
                    
                    placePin.image = annotationIcon[(selectedAnnotation?.title)!]
                    placeTH.text = placeTh[zoneName]?[(selectedAnnotation?.subtitle)!]
                    placeEN.text = placeEn[zoneName]?[(selectedAnnotation?.subtitle)!]
                    
                } else {
                    
                    hideWherAmI(UIButton())
                    hideMyActivity(UIButton())
                    
                    placePin.image = annotationIcon[(selectedAnnotation?.title)!]
                    placeTH.text = placeTh[zoneName]?[(selectedAnnotation?.subtitle)!]
                    placeEN.text = placeEn[zoneName]?[(selectedAnnotation?.subtitle)!]
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.placeCancel.isHidden = false
                        self.placeView.isHidden = false
                        
                    })
                    
                    isPlaceShowing = true
                    
                }
                
            } else {
                
                if isPlaceShowing {
                    
                    placePin.image = annotationIcon[(selectedAnnotation?.title)!]
                    placeTH.text = facilityTh[(selectedAnnotation?.subtitle)!]
                    placeEN.text = facilityEn[(selectedAnnotation?.subtitle)!]
                    
                } else {
                    
                    hideWherAmI(UIButton())
                    hideMyActivity(UIButton())
                    
                    placePin.image = annotationIcon[(selectedAnnotation?.title)!]
                    placeTH.text = facilityTh[(selectedAnnotation?.subtitle)!]
                    placeEN.text = facilityEn[(selectedAnnotation?.subtitle)!]
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.placeCancel.isHidden = false
                        self.placeView.isHidden = false
                        
                    })
                    
                    isPlaceShowing = true
                    
                }
                
            }
            
        }
        
    }
    
    var timerForShowScrollIndicator: Timer?
    var timerForTimeout: Timer?
    
    func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.001) {
            self.tableView.flashScrollIndicators()
        }
    }
    
    /// Start timer for always show scroll indicator in table view
    func startTimerForShowScrollIndicator() {
        
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
        
    }
    
    /// Stop timer for always show scroll indicator in table view
    func stopTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator?.invalidate()
        self.timerForShowScrollIndicator = nil
        
        self.timerForTimeout?.invalidate()
        self.timerForTimeout = nil
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
            
            startTimerForShowScrollIndicator()
            
            timerForTimeout = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.stopTimerForShowScrollIndicator), userInfo: nil, repeats: false)
            
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
            
            whereAmICancel.isHidden = false
            whereAmIView.isHidden = false
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.009, lonDelta: 0.009)
            
            APIController.getWhereAmI(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, inManageobjectcontext: managedObjectContext!, completion: { (zone) in
                
                self.whereAmILabel.text = zone?["th"]
                
            })
            
        }
        
    }
    
    @IBAction func hideMyActivity(_ sender: UIButton) {
        
        if isMyActivityShowing {
            
            myActivityCancel.isHidden = true
            myActivityView.isHidden = true
            
            isMyActivityShowing = false
            
        }
        
    }
    
    @IBAction func hidePlace(_ sender: UIButton) {
        
        if isPlaceShowing {
            
            placeCancel.isHidden = true
            placeView.isHidden = true
            
            isPlaceShowing = false
            
        }
        
    }
    
    @IBAction func hideNavigator(_ sender: UIButton) {
        
        if isNavigatorShowing {
            
            map.addAnnotations(zoneAnnotations)
            
            map.removeAnnotations(placeAnnotations)
        
            navigatorCancel.isHidden = true
            navigatorView.isHidden = true
            
            isNavigatorShowing = false
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.009, lonDelta: 0.009)
            
        }
        
    }
    
    @IBAction func hideWherAmI(_ sender: UIButton) {
        
        if isCurrentShowing {
            
            currentIcon.image = #imageLiteral(resourceName: "annotation")
            
            whereAmICancel.isHidden = true
            whereAmIView.isHidden = true
            
            isCurrentShowing = false
            
        }
        
    }
    
    @IBAction func eventAroundUser(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toSearch", sender: self)
        
    }
    
    @IBAction func myActivityDetail(_ sender: UIButton) {

        tabBarController?.performSegue(withIdentifier: "toEventDetail", sender: self)
        
//        self.performSegue(withIdentifier: "toEventDetail", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "toEventDetail" {
//            
//            if let destination = segue.destination as? EventDetailTableViewController {
//                
////                destination.activityId = showingMyActivity.activityId
////                destination.bannerUrl = showingMyActivity.bannerUrl
////                destination.topic = showingMyActivity.name
////                destination.locationDesc = ""
////                destination.toRounds = showingMyActivity.toRound
////                destination.desc = showingMyActivity.desc
////                destination.room = showingMyActivity.room
////                destination.place = showingMyActivity.place
////                destination.zoneId = showingMyActivity.faculty
////                destination.latitude = showingMyActivity.latitude
////                destination.longitude = showingMyActivity.longitude
////                destination.pdf = showingMyActivity.pdf
////                destination.toImages = showingMyActivity.toImages
////                destination.toTags = showingMyActivity.toTags
//                destination.managedObjectContext = self.managedObjectContext
//                
//            }
//            
//        }
//    
//        
//    }
    
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
            placeAnnotation.title = "\(shortName)-PLACE"
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
                
                if isFacultyShowing {
                
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.788235294, green: 0.22745098, blue: 0.22745098, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "students-cap")
                idtv.descTh.text = "คณะ/เมือง"
                idtv.descEn.text = "Faculty/Zone"
                
            } else if indexPath.row == 1 {
                
                if isFavoriteShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 1, green: 0.878431373, blue: 0.392156863, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "ico-star")
                idtv.descTh.text = "กิจกรรมของฉัน"
                idtv.descEn.text = "My Event"
                
            } else if indexPath.row == 2 {
                
                if isCanteenShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 1, green: 0.752941176, blue: 0.435294118, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 1, green: 0.596, blue: 0.180392157, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "canteen")
                idtv.descTh.text = "ร้านค้า/อาหาร"
                idtv.descEn.text = "Shop/Food"
                
            } else if indexPath.row == 3 {
                
                if isRegistrationShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.22745098, green: 0.803921569, blue: 0.396078431, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.1412, green: 0.6941, blue: 0.2941, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "user")
                idtv.descTh.text = "จุดลงทะเบียน"
                idtv.descEn.text = "Registration"
                
            } else if indexPath.row == 4 {
                
                if isInformationShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.168627451, green: 0.878431373, blue: 0.811764706, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.129411765, green: 0.7922, blue: 0.725490196, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "icon")
                idtv.descTh.text = "จุดประชาสัมพันธ์"
                idtv.descEn.text = "Information"
                
            } else if indexPath.row == 5 {
                
                if isToiletShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.37254902, green: 0.650980392, blue: 0.890196078, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.22, green: 0.5725, blue: 0.878, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "toilet")
                idtv.descTh.text = "ห้องน้ำ"
                idtv.descEn.text = "Toilet"
                
            } else if indexPath.row == 6 {
                
                if isRallyShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.466666667, green: 0.352941176, blue: 0.62745098, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.361, green: 0.2588, blue: 0.6941, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "flag")
                idtv.descTh.text = "กิจกรรมแรลลี่"
                idtv.descEn.text = "Rally"
                
            } else if indexPath.row == 7 {
                
                if isCarParkShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.333333333, green: 0.501960784, blue: 0.647058824, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.250980392, green: 0.423529412, blue: 0.57254902, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "parking-sign")
                idtv.descTh.text = "ที่จอดรถ"
                idtv.descEn.text = "Car Park"
                
            } else if indexPath.row == 8 {
                
                if isEmergencyShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.976470588, green: 0.180392157, blue: 0.203921569, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.788235294, green: 0.074509804, blue: 0.152941176, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "emergency")
                idtv.descTh.text = "จุดปฐมพยาบาล"
                idtv.descEn.text = "EMERGENCY"
                
            } else if indexPath.row == 9 {
                
                if isPrayerShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red: 0.57254902, green: 0.450980392, blue: 0.31372549, alpha: 1).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red: 0.466666667, green: 0.376470588, blue: 0.270588235, alpha: 1).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "muslim-praying")
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
                    
                    turnIconOn(forCell: idtv, annotations: canteenAnnotations, bgColor: UIColor(red: 1, green: 0.752941176, blue: 0.435294118, alpha: 1).cgColor)
                    
                }
                
            } else if indexPath.row == 3 {
                
                if isRegistrationShowing {
                    
                    isRegistrationShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: registrationAnnotations)
                    
                } else {
                    
                    isRegistrationShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: registrationAnnotations, bgColor: UIColor(red: 0.22745098, green: 0.803921569, blue: 0.396078431, alpha: 1).cgColor)
                    
                }
                
                
                
            } else if indexPath.row == 4 {
                
                if isInformationShowing {
                    
                    isInformationShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: informationAnnotations)
                    
                } else {
                    
                    isInformationShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: informationAnnotations, bgColor: UIColor(red: 0.168627451, green: 0.878431373, blue: 0.811764706, alpha: 1).cgColor)
                    
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
                    
                    turnIconOn(forCell: idtv, annotations: rallyAnnotations, bgColor: UIColor(red: 0.466666667, green: 0.352941176, blue: 0.62745098, alpha: 1).cgColor)
                    
                }
                
            } else if indexPath.row == 7 {
                
                if isCarParkShowing {
                    
                    isCarParkShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: carParkAnnotations)
                    
                } else {
                    
                    isCarParkShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: carParkAnnotations, bgColor: UIColor(red: 0.333333333, green: 0.501960784, blue: 0.647058824, alpha: 1).cgColor)
                    
                }
                
                
            } else if indexPath.row == 8 {
                
                if isEmergencyShowing {
                    
                    isEmergencyShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: emergencyAnnotations)
                    
                } else {
                    
                    isEmergencyShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: emergencyAnnotations, bgColor: UIColor(red: 0.976470588, green: 0.180392157, blue: 0.203921569, alpha: 1).cgColor)
                    
                }

            } else if indexPath.row == 9 {
                
                if isPrayerShowing {
                    
                    isPrayerShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: prayerAnnotations)
                    
                } else {
                    
                    isPrayerShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: prayerAnnotations, bgColor: UIColor(red: 0.57254902, green: 0.450980392, blue: 0.31372549, alpha: 1).cgColor)
                    
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
