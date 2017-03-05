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
        var subName: String = ""
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
        var isBlackText:Bool = false
        
    }
    struct interestData {
        
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
        var thDesc: String = ""
        var enDesc: String = ""
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
            
//            print ("section 1")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath)
           
            let name = facultyDatas[indexPath.row].tagEngName
            var tag: String?
            
            if let fetchTag = ZoneData.fetchTagFrom(name: name, inManageobjectcontext: managedObjectContext!){
                
                tag = fetchTag
            }
           
            if let cityCell = cell as? CityCollectionViewCell{
                cityCell.sub = cityDatas[indexPath.row].subName
                cityCell.bg = cityDatas[indexPath.row].bgImage
                cityCell.icon = cityDatas[indexPath.row].iconImage
                cityCell.name = cityDatas[indexPath.row].name
                cityCell.tagname = cityDatas[indexPath.row].tagName
                cityCell.tagColor = cityDatas[indexPath.row].tagColor
                cityCell.id = cityDatas[indexPath.row].subName
                cityCell.fetchTag = tag
            }
            
        }
        else if selectedSection == 2 {
//            print ("section 2")
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath)
            
            var tag: String = facultyDatas[indexPath.row].shortName
            let name = facultyDatas[indexPath.row].tagEngName
            
            if let fetchTag = ZoneData.fetchTagFrom(name: name, inManageobjectcontext: managedObjectContext!){
                
                tag = fetchTag
            }
            
            if let facultyCell = cell as? FacultyCollectionViewCell{
               
                facultyCell.name = facultyDatas[indexPath.row].tagName
                facultyCell.bg = facultyDatas[indexPath.row].tagBack
                facultyCell.icon = facultyDatas[indexPath.row].imgName
                facultyCell.sub = facultyDatas[indexPath.row].tagEngName
                
                facultyCell.tagname = tag
//                facultyCell.tagColor = UIColor.darkGray
//                facultyCell.tagColor = facultyDatas[indexPath.row].tagColor
            }
        }
        else {
//            print ("section else")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath)
            if let interestCell = cell as? InterCollectionViewCell{
                interestCell.name = interestDatas[indexPath.row].tagName
                interestCell.bg = interestDatas[indexPath.row].tagBack
                interestCell.icon = interestDatas[indexPath.row].imgName
                interestCell.sub = interestDatas[indexPath.row].tagEngName
                interestCell.desc = interestDatas[indexPath.row].thDesc
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
//            var isFaculty = false
            var isInterest = false
            var interestDesc: String?
            managedObjectContext?.performAndWait {
                if let cell = sender as? CityCollectionViewCell{
                    
                    name = cell.name ?? ""
                    title = name
                    id = cell.id
                    APIController.downloadActivities(fromZoneID: id ?? "", inManageObjectContext: self.managedObjectContext!, completion: nil)
                    
                }
                else if let cell = sender as? FacultyCollectionViewCell {
                    
                    name = cell.sub ?? ""
                    self.managedObjectContext?.performAndWait {
                        id = ZoneData.fetchIdFrom(name: name, inManageobjectcontext: self.managedObjectContext!)
                    }
                    APIController.downloadActivities(fromZoneID: id ?? "", inManageObjectContext: self.managedObjectContext!, completion: nil)
                    
                    
                    if let facName = cell.name
                    {
                        title = "คณะ" + facName
                    }
//                    isFaculty = true
                    
                }
                
                else if let cell = sender as? InterCollectionViewCell{
                    
                    APIController.downloadActivities(fromTagName: cell.sub ?? "", inManageObjectContext: self.managedObjectContext!, completion: nil)
                    
                    id = cell.sub ?? ""
                    isInterest = true
                    if let titleName = cell.name{
                        
                        title = titleName
                        
                    }
                    interestDesc = cell.desc
                    
                }
            }
            if let dest = segue.destination as? EventsTableViewController{
                
                
                dest.facity = id
//                dest.isFaculty = isFaculty
                dest.isInterest = isInterest
                dest.managedObjectContext = managedObjectContext
                dest.interestDesc = interestDesc
                print("segue success id = \(id)")
            }
            
            segue.destination.title = title
            
        }
    }
    func setupCityData(){
        cityDatas = [
            cityData(name: "Smart City", subName: "589c4d15a8bbbb1c7165d3ed", bgImage: "SMART-bg", iconImage: "smart-icon", tagName: "SMART", tagColor: UIColor(red:0.96, green:0.54, blue:0.29, alpha:1.0)),
            cityData(name: "Health City", subName: "589c4dd0a8bbbb1c7165d3ee", bgImage: "HEALTH-bg", iconImage: "health-icon", tagName: "HEALTH", tagColor: UIColor(red:0.44, green:0.76, blue:0.63, alpha:1.0)),
            cityData(name: "Human City", subName: "589c50e6a8bbbb1c7165d3ef", bgImage: "HUMAN-bg", iconImage: "human-icon", tagName: "HUMAN", tagColor: UIColor(red:0.22, green:0.15, blue:0.38, alpha:1.0)),
            cityData(name: "CU Talk", subName: "589c5330a8bbbb1c7165d3f2", bgImage: "CUTALK-bg", iconImage: "cutalk-icon", tagName: "CUTALK", tagColor: UIColor(red:1.00, green:0.31, blue:0.62, alpha:1.0)),
            cityData(name: "CU@100 Exhibition", subName: "589c536ca8bbbb1c7165d3f3", bgImage: "CU100-bg", iconImage: "cu100-icon", tagName: "CU100", tagColor: UIColor(red:1.00, green:0.31, blue:0.62, alpha:1.0)),
            cityData(name: "Art gallery", subName: "589c52b4a8bbbb1c7165d3f0", bgImage: "ARTGAL-bg", iconImage: "artgal-icon", tagName: "ARTGAL", tagColor: UIColor(red:1.00, green:0.31, blue:0.62, alpha:1.0)),
            cityData(name: "International Forum", subName: "589c5391a8bbbb1c7165d3f4", bgImage: "FORUM-bg", iconImage: "forum-icon", tagName: "FORUM", tagColor: UIColor(red:1.00, green:0.31, blue:0.62, alpha:1.0))
        ]
    }
    
    func setupFacultyData() {
        
        facultyDatas = [
            
            facultyData(imgName: "01_ENG",  tagName: "วิศวกรรมศาสตร์",  tagBack: "01-ENG-bg",  tagEngName: "Faculty of Engineering", shortName: "ENG", tagColor: UIColor(red:0.50, green:0.00, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "02_ARTS",  tagName: "อักษรศาสตร์",  tagBack: "02-ARTS-bg",  tagEngName: "Faculty of Arts", shortName: "ARTS", tagColor: UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0), isBlackText: false),
            facultyData(imgName: "03_SCI",  tagName: "วิทยาศาสตร์",  tagBack: "03-SCI-bg",  tagEngName: "Faculty of Science", shortName: "SCI", tagColor: UIColor(red:1.00, green:1.00, blue:0.00, alpha:1.0), isBlackText: true),
            facultyData(imgName: "04_POLSCI",  tagName: "รัฐศาสตร์",  tagBack: "04-POLSCI-bg",  tagEngName: "Faculty of Political Science", shortName: "POLISC", tagColor: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "05_",  tagName: "สถาปัตยกรรมศาสตร์",  tagBack: "05-ARCH-bg",  tagEngName: "Faculty of Architecture", shortName: "ARCH", tagColor: UIColor(red:0.60, green:0.20, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "06_BANSHI",  tagName: "พาณิชยศาสตร์และการบัญชี",  tagBack: "06-BANSHI-bg",  tagEngName: "Faculty of Commerce and Accountancy", shortName: "BANSHI", tagColor: UIColor(red:0.00, green:0.80, blue:1.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "07_EDU",  tagName: "ครุศาสตร์",  tagBack: "07-EDU-bg",  tagEngName: "Faculty of Education", shortName: "EDU", tagColor: UIColor(red:1.00, green:0.20, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "08_COMMARTS",  tagName: "นิเทศศาสตร์",  tagBack: "08-COMMARTS-bg",  tagEngName: "Faculty of Communication Arts", shortName: "COMMARTS", tagColor: UIColor(red:0.00, green:0.00, blue:0.50, alpha:1.0), isBlackText: false),
            facultyData(imgName: "09_ECON",  tagName: "เศรษฐศาสตร์",  tagBack: "09-ECON-bg",  tagEngName: "Faculty of Economic", shortName: "ECON", tagColor: UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0), isBlackText: true),
            facultyData(imgName: "10_MED",  tagName: "แพทยศาสตร์",  tagBack: "10-MED-bg",  tagEngName: "Faculty of Medicine", shortName: "MED", tagColor: UIColor(red:0.02, green:0.38, blue:0.01, alpha:1.0), isBlackText: false),
            facultyData(imgName: "11_VET",  tagName: "สัตวแพทยศาสตร์",  tagBack: "11-VET-bg",  tagEngName: "Faculty of Veterinary Science", shortName: "VET", tagColor: UIColor(red:0.40, green:0.80, blue:0.80, alpha:1.0), isBlackText: false),
            facultyData(imgName: "12_DENT",  tagName: "ทันตแพทยศาสตร์",  tagBack: "12-DENT-bg",  tagEngName: "Faculty of Dentistry", shortName: "DENT", tagColor: UIColor(red:0.20, green:0.00, blue:0.60, alpha:1.0), isBlackText: false),
            facultyData(imgName: "13_PHARM",  tagName: "เภสัชศาสตร์",  tagBack: "13-PHARM-bg",  tagEngName: "Faculty of Pharmaceutical Sciences", shortName: "PHARM", tagColor: UIColor(red:0.40, green:0.80, blue:0.20, alpha:1.0), isBlackText: false),
            facultyData(imgName: "14_LAW",  tagName: "นิติศาสตร์",  tagBack: "14-LAW-bg",  tagEngName: "Faculty of Law", shortName: "LAW", tagColor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), isBlackText: true),
            facultyData(imgName: "15_FAA",  tagName: "ศิลปกรรมศาสตร์",  tagBack: "15-FAA-bg",  tagEngName: "Faculty of Fine and Applied Arts", shortName: "FAA", tagColor: UIColor(red:0.80, green:0.00, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "16_NUR",  tagName: "พยาบาลศาสตร์",  tagBack: "16-NUR-bg",  tagEngName: "Faculty of Nursing", shortName: "NUR", tagColor: UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "17_AHS",  tagName: "สหเวชศาสตร์",  tagBack: "17-AHS-bg",  tagEngName: "Faculty of Allied Health Sciences", shortName: "AHS", tagColor: UIColor(red:0.80, green:0.60, blue:1.00, alpha:1.0), isBlackText: true),
            facultyData(imgName: "18_PSY",  tagName: "จิตวิทยา",  tagBack: "18-PSY-bg",  tagEngName: "Faculty of Psychology", shortName: "PSY", tagColor: UIColor(red:0.20, green:0.00, blue:1.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "19_SPSC",  tagName: "วิทยาศาสตร์การกีฬา",  tagBack: "19-SPSC-bg",  tagEngName: "Faculty of Sports Science", shortName: "SPSC", tagColor: UIColor(red:1.00, green:0.40, blue:0.00, alpha:1.0), isBlackText: false),
            facultyData(imgName: "20_SAR",  tagName: "สำนักวิชาทรัพยากรการเกษตร",  tagBack: "20-SAR-bg",  tagEngName: "School of Agricultural", shortName: "SAR", tagColor: UIColor(red:0.60, green:0.11, blue:0.11, alpha:1.0), isBlackText: false),
            facultyData(imgName: "21_GRAD",  tagName: "บัณฑิตวิทยาลัย",  tagBack: "21-GRAD-bg",  tagEngName: "Graduate School", shortName: "GRAD", tagColor: UIColor(red:0.75, green:0.38, blue:0.50, alpha:1.0), isBlackText: false),
            
    ]
    }
    func setupInterestData(){
        
        interestDatas = [
            interestData(imgName: "1i", tagName: "พลังงาน", tagBack: "1",  tagEngName: "Energy", thDesc: "นวัตกรรมในการผลิตพลังงานและการพัฒนาพลังงานทดแทน แนวทางในการการอนุรักษ์พลังงาน และการใช้ การจัดการพลังงานอย่างยั่งยืน", enDesc: "Innovation to produce and develop alternative energy The way to conserve and manage sustainably energy."),
            interestData(imgName: "2i", tagName: "สังคมผู้สูงอายุ", tagBack: "2",  tagEngName: "Ageing Society", thDesc: "นวัตกรรมเพื่อการช่วยเหลือและการดูแลผู้สูงอายุ การสร้างความรับรู้และความเข้าใจ รวมถึงแนวทางในการรับมือสังคมผู้สูงอายุ", enDesc: "Innovation to help and concern the ageing society To notice and understand including the way to handle the ageing society."),
            interestData(imgName: "3i", tagName: "ร่างกาย", tagBack: "3",  tagEngName: "Body", thDesc: "การศึกษาสุขภาวะทางด้านร่างกาย และการทำงานของร่างกาย การรับรู้และความเข้าใจที่ถูกต้องในการออกกำลังกาย โภชนาการ การพักผ่อนที่เกี่ยวข้องกับร่างกาย แนวทางในการรักษาและการป้องกันภาวะความผิดปกติของสุขภาพทางด้านร่างกาย ผลงานและสิ่งประดิษฐ์ที่เกี่ยวข้องกับสุขภาวะทางกาย", enDesc: "The study of physical body and physical operation Perception and apprehension in exercise, nutrition, and restive body The way to heal and prevent the abnormality of physical health Pieces of workings and invention involved in physical body."),
            interestData(imgName: "4i", tagName: "จิตใจ", tagBack: "4",  tagEngName: "Mind", thDesc: "การศึกษาสุขภาวะทางด้านจิตใจและอารมณ์ การศึกษาและการวิจัยเชิงจิตวิทยาและพฤติกรรมในด้านต่างๆ แนวทางในการรักษาและการป้องกันรวมถึงการจัดการภาวะความผิดปกติของอารมณ์และจิตใจ", enDesc: "The study of physical body and physical operation Perception and apprehension in exercise, nutrition, and restive body The way to heal and prevent the abnormality of physical health Pieces of workings and invention involved in physical body."),
            interestData(imgName: "5i", tagName: "ปัญหาสังคม", tagBack: "5",  tagEngName: "Social Issues", thDesc: "การศึกษาสภาวะและเหตุการณ์ที่มีผลกระทบต่อกลุ่มคนส่วนใหญ่ในสังคม แนวทางและวิธีการแก้ไขประเด็นที่สังคมรับรู้ว่าเป็นปัญหาที่ต้องการการแก้ไข โครงงานที่เกี่ยวข้องกับการช่วยเหลือสังคมของจุฬาฯ เช่น ค่ายอาสา การพัฒนาชุมชน", enDesc: "The study of events that impact of the majority of the society The way to amend our society problems that need to be handled Project involved in aiding Chula society such as a rural development."),
            interestData(imgName: "6i", tagName: "สิ่งประดิษฐ์", tagBack: "6",  tagEngName: "Invention", thDesc: "นวัตกรรมและสิ่งประดิษฐ์ที่ “จับต้องได้” คิดค้นขึ้นเพื่อตอบสนองความต้องการของมนุษย์", enDesc: "Tangible innovation and invention that respond to the need of humanity."),
            interestData(imgName: "7i", tagName: "คุณภาพชีวิต", tagBack: "7",  tagEngName: "Quality of Life", thDesc: "นวัตกรรมที่พัฒนาความเป็นอยู่ที่ดีของตนเอง และสังคมโดยรวม แนวทางในการแก้ไขปัญหาที่เกิดขึ้นและการพัฒนาชีวิตให้มีความปลอดภัย สะดวกสบาย และสามารถดำรงอยู่ในสังคมยุคปัจจุบันได้อย่างมีความสุข", enDesc: "The innovation that develop the quality of life of oneself and society The way to amend the problems and develop safeness, convenience and maintain the livings in the modern society."),
            interestData(imgName: "8i", tagName: "อาหารและการเกษตร",  tagBack: "8", tagEngName: "Food & Agriculture", thDesc: "การศึกษาเกี่ยวกับตำรับอาหารและโภชนาการในด้านต่างๆ นวัตกรรมด้านการเกษตร และอุตสาหกรรมอาหารต่างๆ การแก้ไขปัญหา และการจัดการการเกษตรอย่างมีประสิทธิภาพ", enDesc: "The study of cuisine and nutrition in different ways Innovation in agriculture and food industry The way to solving agricultural problem and to manage plantation efficiently."),
            interestData(imgName: "9i",  tagName: "ชุมชน",  tagBack: "9",  tagEngName: "Community", thDesc: "การศึกษาความสัมพันธ์ของคนในชุมชนและสังคมในแง่มุมต่างๆ องค์ความรู้ด้านสังคมวิทยา และมานุษวิทยา บทบาทขององค์กรภาคประชาสังคม และภาครัฐในประเทศไทย บทบาทของประเทศไทยกับความสัมพันธ์ระหว่างประเทศ", enDesc: "The study of connecting with people in a community and society in many aspects The acknowledgement in sociology and anthropology The role of civil society and public government of Thailand The role of Thailand and international relations."),
            interestData(imgName: "10i", tagName: "ศิลปวัฒนธรรม", tagBack: "10",  tagEngName: "Art & Culture", thDesc: "การศึกษาและการสร้างสรรค์ผลงานศิลปะด้านต่างๆ เช่น จิตรกรรม วรรณกรรม ดนตรี สถาปัตยกรรม การศึกษาวัฒนธรรมและวัฒนธรรมย่อยในประเด็นต่างๆ", enDesc: "The study and creation of art in different field such as drawing, literature, music, architecture and sculpture The study of culture and subculture in different topics."),
            interestData(imgName: "11i", tagName: "การแพทย์", tagBack: "11",  tagEngName: "Medication", thDesc: "การศึกษาและกรณีศึกษาความผิดปกติของร่างกายหรือจิตใจในเชิงการแพทย์ นวัตกรรมในการวินิจฉัยและการรักษาความผิดปกติที่เกิดขึ้นในร่างกายหรือจิตใจ ยา การผลิตยา และเภสัชกรรม ประเด็นด้านสาธารณสุขและสุขอนามัยที่เกี่ยวข้องกับคนในสังคมโดยรวม", enDesc: "The study of abnormality of mentality and physicality in terms of medical care Innovation of investigation and healings the abnormality in physical body and mentality Medicine, medicine production and pharmacy The point of public health involved in people in society."),
            interestData(imgName: "12i", tagName: "เศรษฐกิจ", tagBack: "12",  tagEngName: "Economy", thDesc: "การศึกษาในประเด็นเกี่ยวกับเศรษฐกิจไทย และเศรษฐกิจโลก องค์ความรู้ ประเด็นปัญหา และการแก้ไขปัญหาเชิงเศรษฐศาสตร์ทั้งจุลภาค และมหภาค การวางแผน และการบริหารจัดการทางธุรกิจ การตลาด การเงิน การจัดการโลจิสติกส์ การศึกษาเศรษฐกิจพอเพียงเพื่อประยุกต์ใช้ในชีวิตประจำวัน", enDesc: "The study of Thai and global economics Knowledge, problems and solving in terms of microeconomics and macroeconomics Planning and management in the business, marketing, finance and logistics The study of efficiency economy for the application in daily life."),
            interestData(imgName: "13i", tagName: "การขนส่ง", tagBack: "13",  tagEngName: "Transportation", thDesc: "การศึกษาในประเด็นต่างๆ ด้านการคมนาคมทางบก ทางน้ำ และทางอากาศ นวัตกรรมในการจัดการและแก้ปัญหาทางด้านการขนส่งและโลจิสติกส์", enDesc: "The study of land, water, and air transportation The innovation that manage and amend the problems in transportation and logistics."),
            interestData(imgName: "14i", tagName: "เทคโนโลยี", tagBack: "14",  tagEngName: "Technology", thDesc: "นวัตกรรมทางด้าน Application และ Software ที่จัดทำขึ้นเพื่อแก้ไขปัญหา และตอบสนองความต้องการของมนุษย์ เทคโนโลยีต่างๆ เช่น AI IoT AR VR MR", enDesc: "The innovation of Application and Software which the purpose is to solve the problem and response the need of humanity Other technologies such as AI, IoT, AR, VR, and MR."),
            interestData(imgName: "15i", tagName: "สิ่งแวดล้อม", tagBack: "15", tagEngName: "Environment", thDesc: "การศึกษาในประเด็นด้านสิ่งแวดล้อมต่างๆ แนวทางในการแก้ไขปัญหาทางด้านสิ่งแวดล้อมที่เกิดขึ้น รวมถึงการพัฒนาในเรื่องของสิ่งแวดล้อมอย่างยั่งยืน นวัตกรรมที่เป็นมิตรต่อสิ่งแวดล้อม หรือสร้างขึ้นเพื่อแก้ไขปัญหาสิ่งแวดล้อม", enDesc: "The study of the matter of environment The innovation and solvings in an environment problem occured and sustainably developing an environment The innovation that is friendly to environment or creation of solvings environmental problems."),
            interestData(imgName: "16i",  tagName: "ภูมิปัญญาไทย",  tagBack: "16",  tagEngName: "Thai Wisdom", thDesc: "องค์ความรู้และสิ่งประดิษฐ์ของแต่ละท้องถิ่นที่ปฏิบัติสืบทอดต่อกันมาช้านานในด้านต่างๆ เช่น ภูมิปัญญาด้านการแพทย์ หัตถกรรม สถาปัตยกรรม โครงงานต่างๆที่เกิดขึ้นในประเทศไทย", enDesc: "Knowledge and invention of local the pass through many generations such as medical care, handicraft, and architecture. Project about Thai wisdom in Thailand."),
            interestData(imgName: "17i",  tagName: "การออกแบบ",  tagBack: "17",  tagEngName: "Design", thDesc: "แนวคิดในการออกแบบเพื่อแก้ไขปัญหาและตอบสนองความต้องการของมนุษย์", enDesc: "The idea of the design for problem solving and response to the need of the humanity."),
            interestData(imgName: "18i",  tagName: "กฎหมาย",  tagBack: "18",  tagEngName: "Law", thDesc: "ประเด็นศึกษาด้านสิทธิและเสรีภาพที่เกิดขึ้นทั้งในไทย และต่างประเทศ จริยศาสตร์ในด้านต่างๆ เช่น จริยธรรม ศีลธรรม ยุติธรรม ปัญหาและแนวทางในการแก้ไขเกี่ยวกับกฎหมาย กระบวนการนิติบัญญัติ และกระบวนการยุติธรรม การศึกษาและทำความเข้าใจในด้านอาชญาวิทยา", enDesc: "The study of Rights and Freedom in Thailand and international countries. The study of morality, ethics and justice. Problems and the ways to amend the problems about the laws, process of legislation and process of justice  The study of criminology."),
            interestData(imgName: "19i",  tagName: "การศึกษา",  tagBack: "19",  tagEngName: "Education", thDesc: "องค์ความรู้ในเรื่องที่เกี่ยวข้องกับการศึกษา เรื่องที่เกี่ยวข้องกับการศึกษาและการบริหารการศึกษาตั้งแต่ระดับประถมศึกษา มัธยมศึกษา และอุดมศึกษา", enDesc: "Knowledge involved with the education The involvement with the education and management from elementary and secondary school to university education."),
            interestData(imgName: "20i",  tagName: "พระราชกรณียกิจ",  tagBack: "20",  tagEngName: "Royal Duties", thDesc: "พระราชกรณียกิจของพระบาทสมเด็จพระเจ้าอยู่หัวรัชกาลที่ 9 และพระบรมวงศานุวงศ์ โครงงาน และกิจกรรมที่เกี่ยวเนื่องกับพระบาทสมเด็จพระเจ้าอยู่หัวรัชกาลที่ 9 และพระบรมวงศานุวงศ์", enDesc: "The royal duties of King Rama VIIII and the royal families The project and activity connected to the King Rama VIIII and the royal family."),
            interestData(imgName: "21i",  tagName: "ความงาม",  tagBack: "21",  tagEngName: "Beauty", thDesc: "ผลงานและองค์ความรู้ที่เกี่ยวข้องกับเวชสำอางต่างๆ เช่น เครื่องสำอาง ผลิตภัณฑ์บำรุงผิว การศึกษาในแฟชั่นด้านต่างๆ เช่น เสื้อผ้า การแต่งหน้า การทำผม เครื่องประดับ การศึกษาเกี่ยวกับสุนทรีศาสตร์ด้านต่างๆ ที่เกี่ยวข้องกับความงาม", enDesc: "Workings and knowledge involved with cosmetics such as skin care product The study of fashions such as clothes, makeups, hairing and accessories The study of aesthetics involved in the beauty."),
            interestData(imgName: "22i",  tagName: "สัตว์และพันธุ์พืช",  tagBack: "22",  tagEngName: "Life", thDesc: "การศึกษาและองค์ความรู้ในด้านต่างๆ ที่เกี่ยวกับสัตว์และพันธุ์พืช การรักษา และการอนุรักษ์สัตว์และพันธุ์พืช", enDesc: "The study and knowledge about animals and plants Recovery and conservation of animals and plants."),
            interestData(imgName: "23i",  tagName: "การสื่อสาร",  tagBack: "23",  tagEngName: "Communication", thDesc: "นวัตกรรมและเทคโนโลยีด้านการสื่อสารต่างๆ ความรู้ด้านการสื่อสารมวลชน การประชาสัมพันธ์ และการเท่าทันสื่อ ผลงานที่เกี่ยวข้องกับการสื่อสาร องค์ความรู้ทางภาษาที่เกี่ยวข้องกับการสื่อสาร ทั้งวจนภาษา และอวจนภาษา", enDesc: "Innovation and technology in Communication Knowledge of mass communication, public relation, and new Workings associated in a communication The knowledge of linguistics involved in communication in both verbal language and non-verbal language."),
            interestData(imgName: "24i",  tagName: "กีฬา",  tagBack: "24",  tagEngName: "Sport", thDesc: "นวัตกรรมหรือองค์ความรู้ที่สอดคล้องกับกีฬา ในด้านต่างๆ", enDesc: "The innovation and knowledge associated in sports."),
            interestData(imgName: "25i",  tagName: "วิทยาศาสตร์",  tagBack: "25",  tagEngName: "Science", thDesc: "องค์ความรู้ด้านวิทยาศาสตร์บริสุทธิ์ และวิทยาศาสตร์ประยุกต์ ความรู้ทั่วไปเกี่ยวกับวิทยาศาสตร์ในชีวิตประจำวัน ผลงานทางวิทยาศาสตร์ที่ช่วยแก้ไขปัญหาด้านต่างๆ", enDesc: "Knowledge on pure science and applied science General scientific knowledge in daily life Scientific Project that solve problems."),
            interestData(imgName: "26i",  tagName: "บันเทิง",  tagBack: "26",  tagEngName: "Entertainment", thDesc: "ผลงาน หรือการแสดงเพื่อความบันเทิงพักผ่อนหย่อนใจ การแสดงต่างๆ เช่น ละคร การเต้นรำ การร้องเพลง", enDesc: "Project or show for entertaining purpose Shows such as play, dancing or singing."),
            interestData(imgName: "27i",  tagName: "ต่างประเทศ",  tagBack: "25",  tagEngName: "International Issue", thDesc: "การศึกษาหรือการวิจัยของจุฬาฯในระดับนานาชาติ ผลงานที่เกี่ยวข้องกับต่างประเทศ การศึกษา หรือประเด็นปัญหาในต่างประเทศ กิจกรรมที่เกี่ยวข้องกับนักเรียนแลกเปลี่ยน หรือชาวต่างชาติ", enDesc: "The study or research of Chulalongkorn University in global level Project related to international countries The study or issue in another nations Activity involving exchange student or foreigner.")
        ]
    }
}
