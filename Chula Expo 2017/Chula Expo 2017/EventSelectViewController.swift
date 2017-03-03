//
//  EventSelectViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBAction func selectTopTap(_ sender: Any) {
        var selectLayout = layout
        if let button = sender as? UIButton{
            
            if selectedSection == button.tag{
                return
            } else {
                updateButton(no: selectedSection, toBlack: true)
                selectedSection = button.tag
                updateButton(no: selectedSection, toBlack: false)
            }
            switch button.tag {
            case 1:
                selectLayout = layout
            case 2:
                selectLayout = layout2
            case 3:
                selectLayout = layout3
            default:
                selectLayout = layout
            }
            
        }
        moveToptabIndicator()
        
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.setCollectionViewLayout(selectLayout, animated: false)
    }
    func changeButtonAttributeColor(_ color: UIColor,for button: UIButton){
        
        button.setTitleColor(color, for: .normal)
    }
    
    func moveToptabIndicator(){
        
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            let sectionWidth = self.topTab.frame.width / 3
            let sectionX = (sectionWidth * (CGFloat)(self.selectedSection - 1) ) + 2
            self.selectionIndicatorView.frame = CGRect(x: sectionX, y: self.topTab.bounds.height-2, width: sectionWidth-4, height: 2)
        })
    }
    
    func updateButton(no: Int,toBlack: Bool){
        
        var color: UIColor
        var button: UIButton
        if toBlack{
            color = UIColor.black
        } else {
            color = UIColor(red:1.00, green:0.43, blue:0.60, alpha:1.0)
        }
        switch no {
        case 1:
            button = topTapButton1
        case 2:
            button = topTapButton2
        case 3:
            button = topTapButton3
        default:
            button = topTapButton1
        }
        changeButtonAttributeColor(color, for: button)
    }
    
    func layoutTopTab(){
        
        moveToptabIndicator()
        updateButton(no: selectedSection, toBlack: false)
    }
    
    func setupTopTap(){
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.tabBarController?.tabBar.isTranslucent = true
        var selectionIndicatorFrame : CGRect = CGRect()
        let sectionWidth = topTab.frame.width / 3
        selectionIndicatorFrame = CGRect(x: (sectionWidth * (CGFloat)(selectedSection - 1) ) + 2 , y: topTab.bounds.height-2, width: sectionWidth - 4, height: 2)
        selectionIndicatorView = UIView(frame: selectionIndicatorFrame)
        selectionIndicatorView.backgroundColor = UIColor(red:1.00, green:0.43, blue:0.60, alpha:1.0)
        
        let shadowPath = UIBezierPath(rect: topTab.bounds)
        topTab.layer.shadowColor = UIColor.darkGray.cgColor
        topTab.layer.shadowOffset = CGSize(width: 0, height: 0)
        topTab.layer.shadowRadius = 1
        topTab.layer.shadowOpacity = 0.5
        topTab.layer.shadowPath = shadowPath.cgPath

        
        topTab.addSubview(selectionIndicatorView)
        
    }

    @IBOutlet weak var topTapButton1: UIButton!
    @IBOutlet weak var topTapButton2: UIButton!
    @IBOutlet weak var topTapButton3: UIButton!
    @IBOutlet weak var topTab: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selectedSection = 1
    private var selectionIndicatorView: UIView = UIView()
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    let layout = CityLayout()
    let layout2 = CityLayout()
    let layout3 = CityLayout()

    
    struct cityData {
        var name: String = ""
        var bgImage: String = ""
        var iconImage: String = ""
        var tagName: String?
        var tagColor: UIColor = UIColor.clear
        
    }
    
    struct facultyData {
        
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
        var shortName: String = ""
        var tagColor: UIColor = UIColor.clear
        
    }
    struct interestData {
        
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
    }
    var cityDatas: [cityData] = []
    var facultyDatas: [facultyData] = []
    var interestDatas: [interestData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EVENTS"
        
        layout2.numberOfColumns = 2
        layout3.numberOfColumns = 3
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cityCell")
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "facultyCell")
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "interestCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        setupCityData()
        setupFacultyData()
        setupInterestData()
        setupTopTap()
        layoutTopTab()
        
        collectionView.collectionViewLayout = layout

//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 35, bottom: 20, right: 35)
//        layout.itemSize = CGSize(width: (self.view.frame.width-60)/2, height: 100)
//        layout.minimumInteritemSpacing = 2.5
//        layout.minimumLineSpacing = 2.5
//        collectionView.collectionViewLayout = layout
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.tabBarController?.tabBar.isTranslucent = false
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        layoutTopTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("numofsection   \(cityDatas.count)")
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch selectedSection {
        case 1:
            return cityDatas.count
        case 2:
            return facultyDatas.count
        case 3:
            return interestDatas.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if selectedSection == 1 {
            
            print ("section 1")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath)
            if let cityCell = cell as? CityCollectionViewCell{
                cityCell.name = cityDatas[indexPath.row].name
                cityCell.bg = cityDatas[indexPath.row].bgImage
                cityCell.icon = cityDatas[indexPath.row].iconImage
                cityCell.sub = "City Events"
                cityCell.tagname = cityDatas[indexPath.row].tagName
                cityCell.tagColor = cityDatas[indexPath.row].tagColor
            }
        }
        else if selectedSection == 2 {
            print ("section 2")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath)
            
            var tag: String = facultyDatas[indexPath.row].shortName
            var name = facultyDatas[indexPath.row].tagEngName
            
            if let fetchTag = ZoneData.fetchTagFrom(name: name, inManageobjectcontext: managedObjectContext!){
                
                tag = fetchTag
            }
            
            if let facultyCell = cell as? FacultyCollectionViewCell{
                facultyCell.name = facultyDatas[indexPath.row].tagName
                facultyCell.bg = facultyDatas[indexPath.row].tagBack
                facultyCell.icon = facultyDatas[indexPath.row].imgName
                facultyCell.sub = facultyDatas[indexPath.row].tagEngName
                facultyCell.tagname = tag
                facultyCell.tagColor = UIColor.darkGray
//                facultyCell.tagColor = facultyDatas[indexPath.row].tagColor
            }
        }
        else {
            print ("section else")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath)
            if let interestCell = cell as? InterCollectionViewCell{
                interestCell.name = interestDatas[indexPath.row].tagName
                interestCell.bg = interestDatas[indexPath.row].tagBack
                interestCell.icon = interestDatas[indexPath.row].imgName
                interestCell.sub = interestDatas[indexPath.row].tagEngName
            }
        }
        
        // Configure the cell
        cell.contentView.layer.cornerRadius = CGFloat(2)
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectFacity"{
            var id: String?
            var name: String = ""
            var title: String = ""
            var isFaculty = false
            managedObjectContext?.performAndWait {
                if let cell = sender as? CityCollectionViewCell{
                    
                    name = cell.name ?? ""
                    title = name
                    
                    id = ZoneData.fetchIdFrom(name: name, inManageobjectcontext: self.managedObjectContext!)
                }
                if let cell = sender as? FacultyCollectionViewCell{
                    APIController.downloadActivities(fromZoneShortName: cell.tagname ?? "", inManageobjectcontext: self.managedObjectContext!, completion: nil)
                    name = cell.sub ?? ""
                    if let facName = cell.name
                    {
                        title = "คณะ" + facName
                    }
                    isFaculty = true
                    id = ZoneData.fetchIdFrom(name: name, inManageobjectcontext: self.managedObjectContext!)
                }
                if let cell = sender as? InterCollectionViewCell{
                    
                    name = cell.name ?? ""
                    title = "Coming Soon"
                    
//                    switch name{
//                    case "Sala Phrakeaw" :
//                        name = "SalaPhakrew"
//                    default :
//                        break
//                    }
                    
                    id = ZoneData.fetchIdFrom(name: name, inManageobjectcontext: self.managedObjectContext!)
                }
            }
            if let dest = segue.destination as? EventsTableViewController{
                
                dest.facity = id
                dest.isFaculty = isFaculty
                dest.managedObjectContext = managedObjectContext
                print("segue success id = \(id)")
            }
            
            segue.destination.title = title
            
        }
    }
    func setupCityData(){
        cityDatas = [
            cityData(name: "Smart City", bgImage: "smartBG", iconImage: "smartICON", tagName: "SMART", tagColor: UIColor(red:1.00, green:0.45, blue:0.00, alpha:1.0)),
            cityData(name: "Health City", bgImage: "healthBG", iconImage: "healthICON", tagName: "HEALTH", tagColor: UIColor(red:0.24, green:0.68, blue:0.20, alpha:1.0)),
            cityData(name: "Human City", bgImage: "humanBG", iconImage: "humanICON", tagName: "HUMAN", tagColor: UIColor(red:0.40, green:0.18, blue:0.57, alpha:1.0)),
            cityData(name: "Sala Phrakeaw", bgImage: "salaBG", iconImage: "salaICON", tagName: nil, tagColor: UIColor.clear),
            cityData(name: "Art Gallery", bgImage: "artBG", iconImage: "artICON", tagName: nil, tagColor: UIColor.clear)
        ]
    }
    
    func setupFacultyData() {
        
        facultyDatas = [
            
             facultyData(imgName: "heartIcon",  tagName: "วิศวกรรมศาสตร์",  tagBack: "eng",  tagEngName: "Faculty of Engineering", shortName: "", tagColor: UIColor.red),
             facultyData(imgName: "heartIcon",  tagName: "แพทยศาสตร์",  tagBack: "med",  tagEngName: "Faculty of Medicine", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "วิทยาศาสตร์",  tagBack: "sci",  tagEngName: "Faculty of Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "พาณิชยศาสตร์และการบัญชี",  tagBack: "banshi",  tagEngName: "Faculty of Commerce and Accountancy", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "รัฐศาสตร์",  tagBack: "poliIcon",  tagEngName: "Faculty of Political Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "ครุศาสตร์",  tagBack: "edu",  tagEngName: "Faculty of Education", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "จิตวิทยา",  tagBack: "psyIcon",  tagEngName: "Faculty of Psychology", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "ทันตแพทยศาสตร์",  tagBack: "dent",  tagEngName: "Faculty of Dentistry", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "นิติศาสตร์",  tagBack: "lawIcon",  tagEngName: "Faculty of Law", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "นิเทศศาสตร์",  tagBack: "commarts",  tagEngName: "Faculty of Communication Arts", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "พยาบาลศาสตร์",  tagBack: "nursIcon",  tagEngName: "Faculty of Nursing", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "วิทยาศาสตร์การกีฬา",  tagBack: "sporIcon",  tagEngName: "Faculty of Sports Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "ศิลปกรรมศาสตร์",  tagBack: "faa",  tagEngName: "Faculty of Fine and Applied Arts", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สถาปัตยกรรมศาสตร์",  tagBack: "achiIcon",  tagEngName: "Faculty of Architecture", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สหเวชศาสตร์",  tagBack: "alliIcon",  tagEngName: "Faculty of Allied Health Sciences", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สัตวแพทยศาสตร์",  tagBack: "vet",  tagEngName: "Faculty of Veterinary Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "อักษรศาสตร์",  tagBack: "arts",  tagEngName: "Faculty of Arts", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "เภสัชศาสตร์",  tagBack: "pharm",  tagEngName: "Faculty of Pharmaceutical Sciences", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "เศรษฐศาสตร์",  tagBack: "econ",  tagEngName: "Faculty of Economic", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สำนักวิชาทรัพยากรการเกษตร",  tagBack: "cusar",  tagEngName: "School of Agricultural", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "บัณฑิตวิทยาลัย",  tagBack: "gradIcon",  tagEngName: "Graduate School", shortName: "", tagColor: UIColor.red),
    ]
    }
    func setupInterestData(){
        
        interestDatas = [
            interestData(imgName: "1i",  tagName: "พลังงาน",  tagBack: "1",  tagEngName: "Energy"),
            interestData(imgName: "2i",  tagName: "สังคมผู้สูงอายุ",  tagBack: "2",  tagEngName: "Aging Society"),
            interestData(imgName: "3i",  tagName: "ร่างกาย",  tagBack: "3",  tagEngName: "Body"),
            interestData(imgName: "4i",  tagName: "จิตใจ",  tagBack: "4",  tagEngName: "Mind"),
            interestData(imgName: "5i",  tagName: "ประเด็นสังคม",  tagBack: "5",  tagEngName: "Social Issue"),
            interestData(imgName: "6i",  tagName: "สิ่งประดิษฐ์",  tagBack: "6",  tagEngName: "Invention"),
            interestData(imgName: "7i",  tagName: "คุณภาพชีวิต",  tagBack: "7",  tagEngName: "Quality of Life"),
            interestData(imgName: "8i",  tagName: "อาหารและการเกษตร",  tagBack: "8",  tagEngName: "Food & Agriculture"),
            interestData(imgName: "9i",  tagName: "ชุมชน",  tagBack: "9",  tagEngName: "Community"),
            interestData(imgName: "10i",  tagName: "ศิลปวัฒนธรรม",  tagBack: "10",  tagEngName: "Art & Culture"),
            interestData(imgName: "11i",  tagName: "การแพทย์",  tagBack: "11",  tagEngName: "Medication"),
            interestData(imgName: "12i",  tagName: "เศรษฐกิจ",  tagBack: "12",  tagEngName: "Economy"),
            interestData(imgName: "13i",  tagName: "การขนส่ง",  tagBack: "13",  tagEngName: "Transportation"),
            interestData(imgName: "14i",  tagName: "เทคโนโลยี",  tagBack: "14",  tagEngName: "Technology"),
            interestData(imgName: "15i",  tagName: "สิ่งแวดล้อม",  tagBack: "15",  tagEngName: "Environment"),
            interestData(imgName: "16i",  tagName: "ภูมิปัญญาไทย",  tagBack: "16",  tagEngName: "Thai Wisdom"),
            interestData(imgName: "17i",  tagName: "การออกแบบ",  tagBack: "17",  tagEngName: "Community"),
            interestData(imgName: "18i",  tagName: "กฎหมาย",  tagBack: "18",  tagEngName: "Law"),
            interestData(imgName: "19i",  tagName: "การศึกษา",  tagBack: "19",  tagEngName: "Education"),
            interestData(imgName: "20i",  tagName: "พระราชกรณียกิจ",  tagBack: "20",  tagEngName: "Royal Duties"),
            interestData(imgName: "21i",  tagName: "ความงาม",  tagBack: "21",  tagEngName: "Beauty"),
            interestData(imgName: "22i",  tagName: "สัตว์และพันธุ์พืช",  tagBack: "22",  tagEngName: "Life"),
            interestData(imgName: "23i",  tagName: "ภาษาและการสื่อสาร",  tagBack: "23",  tagEngName: "Communication"),
            interestData(imgName: "24i",  tagName: "กีฬา",  tagBack: "24",  tagEngName: "Sport")
        ]
    }
}
