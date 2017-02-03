//
//  TagTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/2/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var tags = ["SMART", "ENG"]
    var tagsColor = [UIColor.orange, UIColor(red: 0.62, green: 0.043, blue: 0.06, alpha: 1)]
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var tagCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as UICollectionViewCell
        
        let tagLabel = cell.viewWithTag(1) as! UILabel
        
        tagLabel.text = tags[indexPath.row]
        tagLabel.backgroundColor = tagsColor[indexPath.row]
        tagLabel.layer.cornerRadius = 6
        tagLabel.layer.masksToBounds = true
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(2)
        
        return CGSize(width: 60, height: 25)
        
    }

}
