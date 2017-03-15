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
import Answers

class SecondViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet var iconDescView: UIView!
    @IBOutlet var iconDescLabel: UILabel!
    @IBOutlet var descIcon: UIImageView!
    @IBOutlet var iconDescButton: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var popbusButtonView: UIView!
    @IBOutlet weak var popbusDesc: UILabel!
    @IBOutlet weak var route1: UIButton!
    @IBOutlet weak var route2: UIButton!
    @IBOutlet weak var route3: UIButton!
    @IBOutlet weak var route5: UIButton!
    
    
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
    
    let popBusRouteLocation = [
        [
            //สาย1
            CLLocation(latitude: 13.74562, longitude: 100.53076),
            CLLocation(latitude: 13.74604, longitude: 100.53133),
            CLLocation(latitude: 13.74532, longitude: 100.53563),
            CLLocation(latitude: 13.74522, longitude: 100.53571),
            CLLocation(latitude: 13.73429, longitude: 100.53400),
            CLLocation(latitude: 13.73500, longitude: 100.52918),
            CLLocation(latitude: 13.74563, longitude: 100.53076)
        ],
        [
            //สาย2
            CLLocation(latitude: 13.73959, longitude: 100.52951),
            CLLocation(latitude: 13.73794, longitude: 100.52924),
            CLLocation(latitude: 13.73837, longitude: 100.52666),
            CLLocation(latitude: 13.73645, longitude: 100.52635),
            CLLocation(latitude: 13.73636, longitude: 100.52597),
            CLLocation(latitude: 13.73634, longitude: 100.52566),
            CLLocation(latitude: 13.73644, longitude: 100.52532),
            CLLocation(latitude: 13.73663, longitude: 100.52508),
            CLLocation(latitude: 13.73684, longitude: 100.52496),
            CLLocation(latitude: 13.73932, longitude: 100.52546),
            CLLocation(latitude: 13.73927, longitude: 100.52582),
            CLLocation(latitude: 13.73965, longitude: 100.52586),
            CLLocation(latitude: 13.73945, longitude: 100.52717),
            CLLocation(latitude: 13.74631, longitude: 100.52850),
            CLLocation(latitude: 13.74651, longitude: 100.52734),
            CLLocation(latitude: 13.74637, longitude: 100.52706),
            CLLocation(latitude: 13.74644, longitude: 100.52667),
            CLLocation(latitude: 13.74652, longitude: 100.52657),
            CLLocation(latitude: 13.74675, longitude: 100.52512),
            CLLocation(latitude: 13.74445, longitude: 100.52471),
            CLLocation(latitude: 13.74387, longitude: 100.52808),
            CLLocation(latitude: 13.73991, longitude: 100.52731),
            CLLocation(latitude: 13.73961, longitude: 100.52951)
            
        ],
        [
            //สาย3
            CLLocation(latitude: 13.73600, longitude: 100.53188),
            CLLocation(latitude: 13.73615, longitude: 100.53091),
            CLLocation(latitude: 13.73472, longitude: 100.53069),
            CLLocation(latitude: 13.73421, longitude: 100.53417),
            CLLocation(latitude: 13.73310, longitude: 100.53403),
            CLLocation(latitude: 13.73284, longitude: 100.53614),
            CLLocation(latitude: 13.73326, longitude: 100.53619),
            CLLocation(latitude: 13.73333, longitude: 100.53548),
            CLLocation(latitude: 13.73296, longitude: 100.53543),
            CLLocation(latitude: 13.73313, longitude: 100.53408),
            CLLocation(latitude: 13.73423, longitude: 100.53421),
            CLLocation(latitude: 13.73460, longitude: 100.53173),
            CLLocation(latitude: 13.73601, longitude: 100.53188)
            
        ],
        [
            //สาย4
            CLLocation(latitude: 13.74270, longitude: 100.53014),
            CLLocation(latitude: 13.74342, longitude: 100.52606),
            CLLocation(latitude: 13.73573, longitude: 100.52468),
            CLLocation(latitude: 13.73507, longitude: 100.52898),
            CLLocation(latitude: 13.74271, longitude: 100.53013)
            
        ]
        
    ]
    
    var popBusPathOverlay = [MKOverlay]()
    
    var userLocation = CLLocation(latitude: 13.739957, longitude: 100.532107)
    
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
                            "FON": #imageLiteral(resourceName: "PIN-NUR"),
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
                            "PNC": #imageLiteral(resourceName: "FAC-PNC"),
                            "PNC-PLACE": #imageLiteral(resourceName: "PLACE-PNC") ,
                            "TRCN": #imageLiteral(resourceName: "FAC-TRCN"),
                            "TRCN-PLACE": #imageLiteral(resourceName: "PLACE-TRCN"),
                            "RCU": #imageLiteral(resourceName: "FAC-RCU"),
                            "RCU-PLACE": #imageLiteral(resourceName: "PLACE-RCU"),
                            "TOILET": #imageLiteral(resourceName: "TOILET"),
                            "CANTEEN": #imageLiteral(resourceName: "FOOD"),
                            "CARPARK": #imageLiteral(resourceName: "PARK"),
                            "PRAYER": #imageLiteral(resourceName: "PRAY"),
                            "EMERGENCY": #imageLiteral(resourceName: "AID"),
                            "INFORMATION": #imageLiteral(resourceName: "INFO"),
                            "REGISTRATION": #imageLiteral(resourceName: "REGIS"),
                            "BUSSTOP": #imageLiteral(resourceName: "BUS"),
                            "FAVORITEDANDRESERVED": #imageLiteral(resourceName: "FAV"),
                            "INFO": #imageLiteral(resourceName: "INFO"),
                            "INFO-PLACE": #imageLiteral(resourceName: "INFO"),
                            "SPONSOR1": #imageLiteral(resourceName: "CTY-SPONSOR"),
                            "SPONSOR1-PLACE": #imageLiteral(resourceName: "CTY-SPONSOR"),
                            "SPONSOR2": #imageLiteral(resourceName: "CTY-SPONSOR"),
                            "SPONSOR2-PLACE": #imageLiteral(resourceName: "CTY-SPONSOR"),
                            "LEARNNET": #imageLiteral(resourceName: "LEARNNET"),
                            "LEARNNET-PLACE": #imageLiteral(resourceName: "LEARNNET"),
                            "ACTIVITY": #imageLiteral(resourceName: "CTY-ACTIVITY")
                            
    
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
    var busStopAnnotations = [MKPointAnnotation]()
    
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
    var isBusStopShowing = false
    
    var countToSend = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Answers.logContentView(withName: "Second",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
        self.view.setNeedsLayout()
    
        map.delegate = self
        
        map.showsCompass = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.011, lonDelta: 0.011)
    
        
        eventAroundUser.titleLabel?.adjustsFontSizeToFitWidth = true
        myActivityDetail.titleLabel?.adjustsFontSizeToFitWidth = true
        
        fetchZoneAnnotation()
        fetchFacilityAnnotation()
        addZoneAnnotation()
        addFacilityAnnotation()
        
        createPopbusPolyLine()
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
        
        popbusButtonView.frame = CGRect(x: iconDescView.bounds.width * 8 / 170, y: UIScreen.main.bounds.height * 365 / 667, width: iconDescView.bounds.width * 154 / 170, height: UIScreen.main.bounds.height * 65 / 667)
        popbusButtonView.layer.backgroundColor = UIColor(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1).cgColor
        popbusButtonView.layer.cornerRadius = iconDescView.frame.height / 2
        
        route1.frame = CGRect(x: popbusButtonView.bounds.width * 6.5 / 154, y: popbusButtonView.bounds.height * 30 / 67, width: popbusButtonView.bounds.width * 30 / 154, height: popbusButtonView.bounds.width * 30 / 154)
        route1.layer.cornerRadius = route1.frame.height / 2
        route1.layer.borderColor = UIColor(red: 0.850980392, green: 0.019607843, blue: 0, alpha: 1).cgColor
        route1.layer.borderWidth = 0
        
        route2.frame = CGRect(x: popbusButtonView.bounds.width * 43.5 / 154, y: popbusButtonView.bounds.height * 30 / 67, width: popbusButtonView.bounds.width * 30 / 154, height: popbusButtonView.bounds.width * 30 / 154)
        route2.layer.cornerRadius = route1.frame.height / 2
        route2.layer.borderColor = UIColor(red: 0.078431373, green: 0.443137255, blue: 0.764705882, alpha: 1).cgColor
        route2.layer.borderWidth = 0
        
        route3.frame = CGRect(x: popbusButtonView.bounds.width * 80.5 / 154, y: popbusButtonView.bounds.height * 30 / 67, width: popbusButtonView.bounds.width * 30 / 154, height: popbusButtonView.bounds.width * 30 / 154)
        route3.layer.cornerRadius = route1.frame.height / 2
        route3.layer.borderColor = UIColor(red: 90 / 255, green: 167/255, blue: 58 / 255, alpha: 1).cgColor
        route3.layer.borderWidth = 0
        
        route5.frame = CGRect(x: popbusButtonView.bounds.width * 117.5 / 154, y: popbusButtonView.bounds.height * 30 / 67, width: popbusButtonView.bounds.width * 30 / 154, height: popbusButtonView.bounds.width * 30 / 154)
        route5.layer.cornerRadius = route1.frame.height / 2
        route5.layer.borderColor = UIColor(red: 102 / 255, green: 0/255, blue: 204 / 255, alpha: 1).cgColor
        route5.layer.borderWidth = 0
        
        self.popbusButtonView.frame = CGRect(x: self.iconDescView.bounds.width * 8 / 170, y: self.iconDescView.frame.width * 4 / 17, width: self.iconDescView.bounds.width * 154 / 170, height: 0)
        
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
        
        if countToSend % 25 == 0 {
            
            APIController.getWhereAmI(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude, inManageobjectcontext: managedObjectContext!, completion: { (zone) in
                
                self.whereAmILabel.text = zone?["th"] ?? "\'ไม่พบข้อมูล\'"
                self.map.userLocation.title = "คุณอยู่ที่\(zone?["th"] ?? "\'ไม่พบข้อมูล\'")"
                
            })
            
            
        }
        
        map.showsUserLocation = true
        
        countToSend += 1
        print(countToSend)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
    }
    
    func createPopbusPolyLine(){
        
        addPopBusRouteToMap(locations: popBusRouteLocation[0]) { (polyline) in
            
            polyline.title = "first"
            self.popBusPathOverlay.append(polyline as MKOverlay)
            
        }
        
        addPopBusRouteToMap(locations: popBusRouteLocation[1]) { (polyline) in
            
            polyline.title = "second"
            self.popBusPathOverlay.append(polyline as MKOverlay)
        }
        
        addPopBusRouteToMap(locations: popBusRouteLocation[2]) { (polyline) in
            
            polyline.title = "third"
            self.popBusPathOverlay.append(polyline as MKOverlay)
            
        }
        
        addPopBusRouteToMap(locations: popBusRouteLocation[3]) { (polyline) in
            
            polyline.title = "fifth"
            self.popBusPathOverlay.append(polyline as MKOverlay)
            
        }
        
    }
    
    func addPopBusRouteToMap(locations: [CLLocation?], completion: ((MKPolyline) -> Void)?) {
        
        let coordinates = locations.map { (location) -> CLLocationCoordinate2D in
            
            return (location?.coordinate)!
            
        }
        
        let popBusPolyline = MKPolyline(coordinates: coordinates, count: locations.count)
        
        completion?(popBusPolyline)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRender = MKPolylineRenderer(overlay: overlay);
        
        if overlay.title! == "first"{
            
            polylineRender.strokeColor = UIColor(red: 0.952941176, green: 0.258823529, blue: 0.180392157, alpha: 1)
            polylineRender.lineWidth = 3;
            
        } else if overlay.title! == "second" {
            
            polylineRender.strokeColor = UIColor(red: 0.266666667, green: 0.549019608, blue: 0.796078431, alpha: 1)
            polylineRender.lineWidth = 3;
            
        } else if overlay.title! == "third" {
            
            polylineRender.strokeColor = UIColor(red: 0.494117647, green: 0.764705882, blue: 0.376470588, alpha: 1)
            polylineRender.lineWidth = 3;
            
        } else {
            
            polylineRender.strokeColor = UIColor(red: 102 / 255, green: 0/255, blue: 204 / 255, alpha: 1)
            polylineRender.lineWidth = 3;
            
        }
        
        return polylineRender;
        
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
        
        if annotation.title!! == "TOILET" || annotation.title!! == "CANTEEN" || annotation.title!! == "CARPARK" || annotation.title!! == "INFORMATION" || annotation.title!! == "REGISTRATION" || annotation.title!! == "EMERGENCY" || annotation.title!! == "PRAYER" || annotation.title!! == "MARKET" || annotation.title!! == "BUSSTOP" || annotation.title!! == "RALLY" || annotation.title!! == "FAVORITEDANDRESERVED" || annotation.title!! == "INFO" {
            
            annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 25, height: 32.75)
            
        } else {
            
            annotationView?.frame = CGRect(x: (annotationView?.frame.origin.x)!, y: (annotationView?.frame.origin.y)!, width: 32, height: 47.11)
            
        }
            
        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
        annotationView?.rightCalloutAccessoryView = rightButton
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if view.annotation is MKUserLocation {
            
            
        } else {
            
            let selectedAnnotation = view.annotation as? MKPointAnnotation
            
            if isDescShowing {
                
                iconDescButtonTapped(gestureRecognizer: UITapGestureRecognizer())
                
            }
            
            if selectedAnnotation?.subtitle == "ZONE" || selectedAnnotation?.subtitle == "RALLY" {
                
                map.removeAnnotations(zoneAnnotations)
                map.removeAnnotations(rallyAnnotations)
                
                addPlaceAnnotation(forZone: (selectedAnnotation?.title)!)
                
                if selectedAnnotation?.subtitle != "RALLY" {
                    
                    setCurrentRegion(lat: zoneLatitude[(selectedAnnotation?.title)!]!, lon: zoneLongitude[(selectedAnnotation?.title)!]!, latDelta: 0.003, lonDelta: 0.003)
                    
                }
                
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
                
                self.popbusButtonView.frame = CGRect(x: self.iconDescView.bounds.width * 8 / 170, y: self.iconDescView.frame.width * 4 / 17, width: self.iconDescView.bounds.width * 154 / 170, height: 0)
                
            })
            
        } else {
            
            isDescShowing = !isDescShowing
            descIcon.image = #imageLiteral(resourceName: "listPink")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.iconDescView.frame = CGRect(x: self.iconDescView.frame.origin.x, y: self.iconDescView.frame.origin.y, width: self.iconDescView.frame.width, height:  UIScreen.main.bounds.height * 435 / 667)
                
                self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.iconDescView.frame.width * 4 / 17, width: self.tableView.frame.width, height: UIScreen.main.bounds.height * 317 / 667)
               
                self.popbusButtonView.frame = CGRect(x: self.iconDescView.bounds.width * 8 / 170, y: UIScreen.main.bounds.height * 365 / 667, width: self.iconDescView.bounds.width * 154 / 170, height: UIScreen.main.bounds.height * 65 / 667)
                
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
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.0124, lonDelta: 0.0124)
            
//            APIController.getWhereAmI(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, inManageobjectcontext: managedObjectContext!, completion: { (zone) in
//                
//                self.whereAmILabel.text = zone?["th"]
//                
//            })
            
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
            
            if isRallyShowing {
                
                map.addAnnotations(rallyAnnotations)
                
            }
            
            map.addAnnotations(zoneAnnotations)
            
            map.removeAnnotations(placeAnnotations)
        
            navigatorCancel.isHidden = true
            navigatorView.isHidden = true
            
            isNavigatorShowing = false
            
            setCurrentRegion(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, latDelta: 0.0124, lonDelta: 0.0124)
            
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
        
    }
    
    func addZoneAnnotation() {
        
        zoneAnnotations.removeAll()
        rallyAnnotations.removeAll()
        
        for (key, _) in zoneEn {
            
            let zoneCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: zoneLatitude[key]!, longitude: zoneLongitude[key]!)
            
            let zoneAnnotation = MKPointAnnotation()
            zoneAnnotation.coordinate = zoneCoordinate
            zoneAnnotation.title = key
            
            if key == "RALLY" {
                
                zoneAnnotation.subtitle = "RALLY"
                rallyAnnotations.append(zoneAnnotation)
                
                
            } else {
                
                zoneAnnotation.subtitle = "ZONE"
                zoneAnnotations.append(zoneAnnotation)
                map.addAnnotation(zoneAnnotation)
                
            }
            
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
        carParkAnnotations.removeAll()
        prayerAnnotations.removeAll()
        emergencyAnnotations.removeAll()
        busStopAnnotations.removeAll()
        
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
                
            case "BUSSTOP":
                
                busStopAnnotations.append(facilityAnnotation)
                
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
        
        return 11
        
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
                
            } else if indexPath.row == 10 {
                
                if isBusStopShowing {
                    
                    idtv.iconView.layer.backgroundColor = UIColor(red:1.00, green:0.55, blue:0.71, alpha:1.0).cgColor
                    idtv.iconView.layer.borderWidth = 3
                    
                } else {
                    
                    idtv.iconView.layer.backgroundColor = UIColor.lightGray.cgColor
                    idtv.iconView.layer.borderWidth = 0
                    
                }
                
                idtv.iconView.layer.borderColor = UIColor(red:1.00, green:0.40, blue:0.63, alpha:1.0).cgColor
                idtv.iconImage.image = #imageLiteral(resourceName: "front-bus")
                idtv.descTh.text = "ป้ายรถประจำทาง"
                idtv.descEn.text = "Bus Stop"
                
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
                
            } else if indexPath.row == 10 {
                
                if isBusStopShowing {
                    
                    isBusStopShowing = false
                    
                    turnIconOff(forCell: idtv, annotations: busStopAnnotations)
                    
                } else {
                    
                    isBusStopShowing = true
                    
                    turnIconOn(forCell: idtv, annotations: busStopAnnotations, bgColor: UIColor(red:1.00, green:0.55, blue:0.71, alpha:1.0).cgColor)
                    
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

    @IBAction func route1(_ sender: UIButton) {
        
        let isShowing = map.overlays.contains { (popbusOverlay) -> Bool in
            
            if popbusOverlay.title! == "first" {
                
                return true
                
            }
            
            return false
            
        }
        
        if isShowing {
            
            map.remove(popBusPathOverlay[0])
            
            route1.layer.backgroundColor = UIColor.lightGray.cgColor
            route1.layer.borderWidth = 0
            
        } else {
            
            map.add(popBusPathOverlay[0])
            
            route1.layer.backgroundColor = UIColor(red: 230 / 255, green: 62 / 255, blue: 59 / 255, alpha: 1).cgColor
            route1.layer.borderWidth = 2
            
        }
        
    }
    
    @IBAction func route2(_ sender: UIButton) {
        
        let isShowing = map.overlays.contains { (popbusOverlay) -> Bool in
            
            if popbusOverlay.title! == "second" {
                
                return true
                
            }
            
            return false
            
        }
        
        if isShowing {
            
            map.remove(popBusPathOverlay[1])
            
            route2.layer.backgroundColor = UIColor.lightGray.cgColor
            route2.layer.borderWidth = 0
            
        } else {
            
            map.add(popBusPathOverlay[1])
            
            route2.layer.backgroundColor = UIColor(red: 68 / 255, green: 140 / 255, blue: 203 / 255, alpha: 1).cgColor
            route2.layer.borderWidth = 2
            
        }
        
    }
    
    @IBAction func route3(_ sender: UIButton) {
        
        let isShowing = map.overlays.contains { (popbusOverlay) -> Bool in
            
            if popbusOverlay.title! == "third" {
                
                return true
                
            }
            
            return false
            
        }
        
        if isShowing {
            
            map.remove(popBusPathOverlay[2])
            
            route3.layer.backgroundColor = UIColor.lightGray.cgColor
            route3.layer.borderWidth = 0
            
        } else {
            
            map.add(popBusPathOverlay[2])
            
            route3.layer.backgroundColor = UIColor(red: 126 / 255, green: 195 / 255, blue: 96 / 255, alpha: 1).cgColor
            route3.layer.borderWidth = 2
            
        }
        
    }
    
    @IBAction func route5(_ sender: UIButton) {
        
        let isShowing = map.overlays.contains { (popbusOverlay) -> Bool in
            
            if popbusOverlay.title! == "fifth" {
                
                return true
                
            }
            
            return false
            
        }
        
        if isShowing {
            
            map.remove(popBusPathOverlay[3])
            
            route5.layer.backgroundColor = UIColor.lightGray.cgColor
            route5.layer.borderWidth = 0
            
        } else {
            
            map.add(popBusPathOverlay[3])
            
            route5.layer.backgroundColor = UIColor(red: 144 / 255, green: 68 / 255, blue: 225 / 255, alpha: 1).cgColor
            route5.layer.borderWidth = 2
            
        }
        
    }
    
}
