//
//  EventHeaderTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/31/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventHeaderTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var timeTableCollectionView: UICollectionView!
    @IBOutlet var reserveView: UIView!

    var date = ["15 มีนาคม", "16 มีนาคม", "17 มีนาคม", "18 มีนาคม", "19 มีนาคม"]
    var time = [["08.00-09.00", "10.00-11.00", "13.00-14.00"],
                ["09.00-10.00", "11.00-12.00", "14.00-15.00"],
                ["08.00-09.00", "10.00-11.00", "13.00-14.00", "15.00-16.00"],
                ["09.00-10.00", "11.00-12.00", "14.00-15.00"],
                ["08.00-09.00", "10.00-11.00"]
                ]
    
    var isFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeTableCollectionView.delegate = self
        timeTableCollectionView.dataSource = self
        
        //timeTableCollectionView.contentOffset = CGPoint(x: 0, y: 50)
        reserveView.layer.borderWidth = 2
        reserveView.layer.borderColor = UIColor(red: 0.9922, green: 0.431, blue: 0.604, alpha: 1).cgColor
        reserveView.layer.cornerRadius = 4
        reserveView.layer.masksToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventHeaderTableViewCell.tapOnButton))
        reserveView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return date.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row % 4 == 0 {
            
            return CGSize(width: 55, height: 15)
            
        } else {
            
            return CGSize(width: 72, height: 15)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return time[section].count + 1 + (time[section].count / 4)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as UICollectionViewCell
        
        let dateTimeLabel = cell.viewWithTag(1) as! UILabel
        
        if indexPath.row == 0 {
            
            dateTimeLabel.text = date[indexPath.section]
            
        } else if indexPath.row % 4 == 0 {
            
            dateTimeLabel.text = ""
            
        } else {
            
            dateTimeLabel.text = time[indexPath.section][indexPath.row - 1 - (indexPath.row / 4)]
            dateTimeLabel.textColor = UIColor.gray
            
        }
        
        return cell
        
    }
    
    func tapOnButton() {
        
        if isFavorite {
            
            let confirm = UIAlertController(title: "ยกเลิกการรายการโปรด", message: "คุณต้องการยกเลิกรายการโปรดใช่หรือไม่", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
            
            confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                
                self.isFavorite = false
                
                
            }))
            
            if let parentViewController = parentViewController as? UITableViewController {
                
                parentViewController.present(confirm, animated: true, completion: nil)
                
            }
            
        } else {
            
            let confirm = UIAlertController(title: "ยืนยันรายการโปรด", message: "คุณต้องการเพิ่มเข้ารายการโปรดใช่หรือไม่", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
            
            confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                
                self.isFavorite = true
                
                
            }))
            
            if let parentViewController = parentViewController as? UITableViewController {
                
                parentViewController.present(confirm, animated: true, completion: nil)
                
            }
            
        }

        
    }

}
