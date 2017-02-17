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
        self.navigationController?.navigationBar.isTranslucent = false
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
                cityCell.sub = "200 Events"
                cityCell.tagname = cityDatas[indexPath.row].tagName
                cityCell.tagColor = cityDatas[indexPath.row].tagColor
            }
        }
        else if selectedSection == 2 {
            print ("section 2")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath)
            
            var tag: String = facultyDatas[indexPath.row].shortName
            var name = facultyDatas[indexPath.row].tagEngName
            
            switch name{
            case "Faculty of Sports Science" :
                name = "Faculty of Sport Science"
            default :
                break
            }
            
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
            managedObjectContext?.performAndWait {
                if let cell = sender as? CityCollectionViewCell{
                    
                    name = cell.name ?? ""
                    title = name
                    
                    switch name{
                    case "Sala Phrakeaw" :
                        name = "SalaPhakrew"
                    default :
                        break
                    }
        
                    id = ZoneData.fetchIdFrom(name: name, inManageobjectcontext: self.managedObjectContext!)
                }
                if let cell = sender as? FacultyCollectionViewCell{
                    
                    name = cell.sub ?? ""
                    if let facName = cell.name
                    {
                        title = "คณะ" + facName
                    }
                    
                    switch name{
                    case "Faculty of Sports Science" :
                        name = "Faculty of Sport Science"
                    default :
                        break
                    }
                    
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
            facultyData(imgName: "heartIcon",  tagName: "ครุศาสตร์",  tagBack: "eduIcon",  tagEngName: "Faculty of Education", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "จิตวิทยา",  tagBack: "psyIcon",  tagEngName: "Faculty of Psychology", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "ทันตแพทยศาสตร์",  tagBack: "dentIcon",  tagEngName: "Faculty of Dentistry", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "นิติศาสตร์",  tagBack: "lawIcon",  tagEngName: "Faculty of Law", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "นิเทศศาสตร์",  tagBack: "commIcon",  tagEngName: "Faculty of Communication Arts", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "พยาบาลศาสตร์",  tagBack: "nursIcon",  tagEngName: "Faculty of Nursing", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "พาณิชยศาสตร์และการบัญชี",  tagBack: "accIcon",  tagEngName: "Faculty of Commerce and Accountancy", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "รัฐศาสตร์",  tagBack: "poliIcon",  tagEngName: "Faculty of Political Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "วิทยาศาสตร์",  tagBack: "sciIcon",  tagEngName: "Faculty of Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "วิทยาศาสตร์การกีฬา",  tagBack: "sporIcon",  tagEngName: "Faculty of Sports Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "วิศวกรรมศาสตร์",  tagBack: "engIcon",  tagEngName: "Faculty of Engineering", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "ศิลปกรรมศาสตร์",  tagBack: "fineIcon",  tagEngName: "Faculty of Fine and Applied Arts", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สถาปัตยกรรมศาสตร์",  tagBack: "achiIcon",  tagEngName: "Faculty of Architecture", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สหเวชศาสตร์",  tagBack: "alliIcon",  tagEngName: "Faculty of Allied Health Sciences", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สัตวแพทยศาสตร์",  tagBack: "vetIcon",  tagEngName: "Faculty of Veterinary Science", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "อักษรศาสตร์",  tagBack: "artIcon1",  tagEngName: "Faculty of Arts", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "เภสัชศาสตร์",  tagBack: "pharIcon",  tagEngName: "Faculty of Pharmaceutical Sciences", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "เศรษฐศาสตร์",  tagBack: "econIcon",  tagEngName: "Faculty of Economic", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "แพทยศาสตร์",  tagBack: "medIcon",  tagEngName: "Faculty of Medicine", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "สำนักวิชาทรัพยากรการเกษตร",  tagBack: "agriIcon",  tagEngName: "School of Agricultural", shortName: "", tagColor: UIColor.red),
            facultyData(imgName: "heartIcon",  tagName: "บัณฑิตวิทยาลัย",  tagBack: "gradIcon",  tagEngName: "Graduate School", shortName: "", tagColor: UIColor.red),
    ]
    }
    func setupInterestData(){
        
        interestDatas = [
            interestData(imgName: "heartIcon",  tagName: "พระราชกรณียกิจ",  tagBack: "technology",  tagEngName: "Royal Duties"),
            interestData(imgName: "heartIcon",  tagName: "ไทยแลนด์ 4.0",  tagBack: "technology",  tagEngName: "Thailand 4.0"),
            interestData(imgName: "heartIcon",  tagName: "พลังงาน",  tagBack: "technology",  tagEngName: "Energy"),
            interestData(imgName: "heartIcon",  tagName: "สิ่งประดิษฐ์",  tagBack: "technology",  tagEngName: "Invention"),
            interestData(imgName: "heartIcon",  tagName: "การออกแบบ",  tagBack: "technology",  tagEngName: "Design"),
            interestData(imgName: "heartIcon",  tagName: "ไอที",  tagBack: "technology",  tagEngName: "IT"),
            interestData(imgName: "heartIcon",  tagName: "การแพทย์",  tagBack: "technology",  tagEngName: "Medication"),
            interestData(imgName: "heartIcon",  tagName: "ร่างกาย",  tagBack: "technology",  tagEngName: "Body"),
            interestData(imgName: "heartIcon",  tagName: "จิตใจ",  tagBack: "technology",  tagEngName: "Mind"),
            interestData(imgName: "heartIcon",  tagName: "สิ่งแวดล้อม",  tagBack: "technology",  tagEngName: "Environment"),
            interestData(imgName: "heartIcon",  tagName: "สัตว์และพันธุ์พืช",  tagBack: "technology",  tagEngName: "Life"),
            interestData(imgName: "heartIcon",  tagName: "อาหารและน้ำ",  tagBack: "technology",  tagEngName: "Food & Water"),
            interestData(imgName: "heartIcon",  tagName: "ความงาม",  tagBack: "technology",  tagEngName: "Beauty"),
            interestData(imgName: "heartIcon",  tagName: "คุณภาพชีวิต",  tagBack: "technology",  tagEngName: "Quality of Life"),
            interestData(imgName: "heartIcon",  tagName: "สังคมผู้สูงอายุ",  tagBack: "technology",  tagEngName: "Aging Society"),
            interestData(imgName: "heartIcon",  tagName: "เศรษฐกิจ",  tagBack: "technology",  tagEngName: "Economy"),
            interestData(imgName: "heartIcon",  tagName: "ชุมชน",  tagBack: "technology",  tagEngName: "Community"),
            interestData(imgName: "heartIcon",  tagName: "ปัญหาสังคม",  tagBack: "technology",  tagEngName: "Social Issues"),
            interestData(imgName: "heartIcon",  tagName: "การศึกษา",  tagBack: "technology",  tagEngName: "Education"),
            interestData(imgName: "heartIcon",  tagName: "การสื่อสาร",  tagBack: "technology",  tagEngName: "Communication"),
            interestData(imgName: "heartIcon",  tagName: "การขนส่ง",  tagBack: "technology",  tagEngName: "Transportation"),
            interestData(imgName: "heartIcon",  tagName: "ภูมิปัญญาไทย",  tagBack: "technology",  tagEngName: "Thai"),
            interestData(imgName: "heartIcon",  tagName: "ศิลปวัฒนธรรม",  tagBack: "technology",  tagEngName: "Art & Culture"),
            interestData(imgName: "heartIcon",  tagName: "กฎหมาย",  tagBack: "technology",  tagEngName: "Law")
        ]
    }
}
