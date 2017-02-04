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

    var dates = [String]()
    var times = [[String]]()
    
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventHeaderTableViewCell.wasTap))
        reserveView.addGestureRecognizer(tapGestureRecognizer)
        
        reserveView.isUserInteractionEnabled = true
        
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
        
        return times[section].count + 1 + (times[section].count / 4)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as UICollectionViewCell
        
        let dateTimeLabel = cell.viewWithTag(1) as! UILabel
        
        if indexPath.row == 0 {
            
            dateTimeLabel.text = dates[indexPath.section]
            
        } else if indexPath.row % 4 == 0 {
            
            dateTimeLabel.text = ""
            
        } else {
            
            dateTimeLabel.text = times[indexPath.section][indexPath.row - 1 - (indexPath.row / 4)]
            dateTimeLabel.textColor = UIColor.gray
            
        }
        
        return cell
        
    }
    
    func wasTap() {
        
        let parentVC = self.parentViewController!
        
        parentVC.performSegue(withIdentifier: "presentFavorite", sender: parentVC)
        
    }

}
