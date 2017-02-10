//
//  EventHeaderTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/31/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventHeaderTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var topic: String!
    var locationDesc: String!
    var toRounds: NSSet!
    var reservable = false
    var dates = [String]()
    var times = [String: [String]]()
    var dateTimeList = [String]()

    @IBOutlet var reserveIcon: UIImageView!
    @IBOutlet var reserveTitle: UILabel!
    @IBOutlet var reserveDesc: UILabel!
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var timeTableCollectionView: UICollectionView!
    @IBOutlet var reserveView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeTableCollectionView.delegate = self
        timeTableCollectionView.dataSource = self
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        topicLabel.text = self.topic
        placeLabel.text = self.locationDesc
        
        initialReserveButton()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return dates.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row % 4 == 0 {
            
            return CGSize(width: 55, height: 15)
            
        } else {
            
            return CGSize(width: 72, height: 15)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return times[dates[section]]!.count + 1 + (times[dates[section]]!.count / 4)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as UICollectionViewCell
        
        let dateTimeLabel = cell.viewWithTag(1) as! UILabel
        
        if indexPath.row == 0 {
            
            dateTimeLabel.text = dates[indexPath.section]
            
        } else if indexPath.row % 4 == 0 {
            
            dateTimeLabel.text = ""
            
        } else {
            
            dateTimeLabel.text = times[dates[indexPath.section]]?[indexPath.row - 1 - (indexPath.row / 4)]
            dateTimeLabel.textColor = UIColor.gray
            
        }
        
        return cell
        
    }
    
    func wasTap() {
        
        let parentVC = self.parentViewController!
        
        parentVC.performSegue(withIdentifier: "presentFavorite", sender: parentVC)
        
    }
    
    private func initialReserveButton() {
        
        //timeTableCollectionView.contentOffset = CGPoint(x: 0, y: 50)
        reserveView.layer.borderWidth = 2
        reserveView.layer.borderColor = UIColor(red: 0.9922, green: 0.431, blue: 0.604, alpha: 1).cgColor
        reserveView.layer.cornerRadius = 4
        reserveView.layer.masksToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventHeaderTableViewCell.wasTap))
        reserveView.addGestureRecognizer(tapGestureRecognizer)
        
        reserveView.isUserInteractionEnabled = true
        
        if reservable {
            
            reserveIcon.image = #imageLiteral(resourceName: "ticketPink")
            reserveTitle.text = "จอง EVENT"
            reserveDesc.text = "EVENT นี้ต้องสำรองที่นั่งก่อนเข้าร่วม"
            
        }
        
        
    }

}
