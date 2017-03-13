//
//  FaqTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 3/13/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FaqTableViewController: UITableViewController {

    var datas = [data]()
    
    struct data {
        var thumb: UIImage = #imageLiteral(resourceName: "defaultImage")
        var headtext: String = ""
        var descText: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        title = "FAQ"
        prepareData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
            cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath)
            
            if let aboutCell = cell as? AboutAppTableViewCell{
                aboutCell.imageThumb = datas[indexPath.row].thumb
                aboutCell.head = datas[indexPath.row].headtext
                aboutCell.desc = datas[indexPath.row].descText
            }
        
        
        // Configure the cell...
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func prepareData(){
        datas = [
            data(thumb: #imageLiteral(resourceName: "faq"), headtext: "งานจุฬาฯ Expo 2017 จัดวันไหน ?", descText: "งานนี้จัดวันที่ 15-19 มีนาคม 2560 เวลา 9.00-19.00 น. ผู้เข้าชมสามารถมาวันไหนก็ได้ เวลาไหนก็ได้ ไม่จำเป็นต้องมาทุกวัน หรือมาตั้งแต่เริ่มงาน"),
            data(thumb: #imageLiteral(resourceName: "faq"), headtext: "งานจุฬาฯ Expo 2017 มีค่าใช้จ่ายในการเข้างานหรือเปล่า?", descText: "ผู้เข้าชมสามารถมาเยี่ยมชมงานโดยไม่มีค่าใช้จ่ายในการเข้าชมใดๆทั้งสิ้น"),
            data(thumb: #imageLiteral(resourceName: "faq"), headtext: "งานจุฬาฯ Expo 2017 นี้ต้องลงทะเบียนหรือไม่?", descText: "ผู้เข้าชมสามารถลงทะเบียนล่วงหน้าผ่าน application นี้ เพื่ออำนวยความสะดวกในการชมงาน หรือลงทะเบียนในงานวันจริงได้ที่บริเวณประตูหน้าพระบรมราชานุสาวรีย์ฯ นอกจากนี้บางกิจกรรมทั้งของส่วนกลาง และของคณะยังเปิดให้ลงทะเบียนล่วงหน้าผ่าน application อีกด้วย"),
            data(thumb: #imageLiteral(resourceName: "faq"), headtext: "แต่งกายอย่างไรมางานจุฬาฯ Expo 2017?", descText: "ผู้เข้าชมสามารถแต่งกายด้วยชุดสุภาพมางานได้"),
            data(thumb: #imageLiteral(resourceName: "faq"), headtext: "เดินทางมางานจุฬาฯ Expo 2017 ได้อย่างไร?", descText: "งานนี้จัดขึ้นที่จุฬาลงกรณ์มหาวิทยาลัย นอกจากรถส่วนตัวหรือรถแท็กซี่แล้วนั้นสามารถเดินทางได้โดย\n>>1. รถโดยสารประจำทาง ขสมก. สามารถแบ่งเส้นทางเดินรถตามสายถนนทั้ง 4 สาย ดังนี้\n• ถนนพระราม 1 สายรถประจำทางที่ผ่านมหาวิทยาลัย ได้แก่  \n- 15, 16, 25, 40, 48, 54, 73, 73ก, 204, 501, 508(ปากน้ำ)\n- เฉพาะฝั่งสยามสแควร์: 21, 141\n- เฉพาะฝั่งสยามพารากอน: 79\n\n• ถนนพระราม 4 สายรถประจำทางที่ผ่านมหาวิทยาลัย ได้แก่\n- 4, 45, 46, 47, 50, 67, 109, 172, 177, 507, 508(เมกาบางนา)\n- เฉพาะฝั่งจามจุรี: 21, 93, 141\n\n• ถนนพญาไท สายรถประจำทางที่ผ่านมหาวิทยาลัย ได้แก่\n- 25, 29, 34, 36, 40, 47, 50, 93, 113, 172, 177, 187, 501, 508(เมกาบางนา), 529, 542\n- เฉพาะฝั่งจุฬาฯ: 21, 141\n\n• ถนนอังรีดูนังต์ สายรถประจำทางที่ผ่านมหาวิทยาลัย ได้แก่\n- 16\n- เฉพาะฝั่งจุฬาฯ: 21, 141\n\n>>2. รถไฟฟ้ามหานคร (MRT) ลงที่สถานีสามย่าน เมื่อใช้ทางออกหมายเลข 2 จะเจออาคารจัตุรัสจามจุรี ซึ่งน้องสามารถเดิน หรือโดยสารรถประจำทาง เพื่อความสะดวกไปยังสถานที่ต่างๆ ได้\n\n>>3. รถไฟฟ้าบีทีเอส (BTS) ลงที่ สถานีสยาม (Siam Station) หรือสถานีสนามกีฬาแห่งชาติ (National Stadium Station) จากนั้นสามารถใช้บริการรถโดยสารภายในจุฬาฯ โดยสามารถรอได้ที่ หน้าลิโด้ (สถานีสยาม) และสนามกีฬาแห่งชาติ\n\nเมื่อมาถึงจุฬาฯ สามารถเดินทางไปพื้นที่จัดงาน และคณะต่างๆได้ โดยดูแผนที่ผ่าน Application หรือสอบถามสตาฟฝ่ายปฏิคม (สวมเสื้อสีขาว) ที่จะคอยอำนวยความสะดวกให้"),
            data(thumb: #imageLiteral(resourceName: "faq"), headtext: "งานจุฬาฯ Expo 2017 เหมือนกับงานจุฬาฯ วิชาการ หรืองาน Open House หรือไม่?", descText: "งานนี้แตกต่างจากงานจุฬาฯวิชาการ และงาน Open House ตรงที่เป็นงานที่จัดแสดงนวัตกรรมและผลงานทางวิชาการอย่างบูรณาการ โดยไม่ได้แบ่งออกมาตามคณะ แต่แบ่งออกมาเป็น 3 city ได้แก่ smart city, health city และ human city นอกจากนี้ กลุ่มเป้าหมายของงานยังเปิดกว้างกว่าครั้งก่อนๆ โดยมีกลุ่มเป้าหมาย ดังนี้\n>>1. CU family: ครอบครัวจุฬาฯ หมายถึง ศิษย์ปัจจุบัน ศิษย์เก่า คณาจารย์และเจ้าหน้าที่ ที่มีความเกี่ยวข้องกับจุฬาฯ โดยตรง รวมทั้งนักเรียนที่มีความมุ่งหมายจะมาเป็นส่วนหนึ่งในครอบครัวจุฬาฯ ในอนาคต\n>>2. CU Network : บุคคลหรือองค์กรต่างๆ ที่มีความสัมพันธ์กับจุฬาลงกรณ์มหาวิทยาลัย ผ่านทางความร่วมมือรูปแบบต่างๆ\n>>3. CU  innovators : กลุ่มคนที่จะสามารถส่งต่อหรือต่อยอดนวัตกรรมจากผลงานในงานจุฬาฯ Expo 2017 สู่สังคมเพื่อการพัฒนาที่ดีได้อย่างยั่งยืน  เช่น กลุ่มนักลงทุน นักวิชาการ  เป็นต้น"),
            
        ]
    }

}
