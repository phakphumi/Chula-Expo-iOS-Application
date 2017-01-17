//
//  GalleryTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/16/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet var galleryView: UIView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
    @IBOutlet var image7: UIImageView!
    @IBOutlet var image8: UIImageView!
    @IBOutlet var image9: UIImageView!
    @IBOutlet var image10: UIImageView!
    @IBOutlet var image11: UIImageView!
    @IBOutlet var image12: UIImageView!
    
    private static var _galleryHeight: CGFloat = 0
    
    static var galleryHeight: CGFloat {
        
        get {
            
            return self._galleryHeight
            
        }
        set(value) {
            
            self._galleryHeight = value
            
        }
        
    }
    
    private func setImageTag() {
        
        image1.tag = 0
        image2.tag = 1
        image3.tag = 2
        image4.tag = 3
        image5.tag = 4
        image6.tag = 5
        image7.tag = 6
        image8.tag = 7
        image9.tag = 8
        image10.tag = 9
        image11.tag = 10
        image12.tag = 11
        
    }
    
    func wasTapped(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        setImageTag()
        
    }
    
    override func layoutSubviews() {
        
        GalleryTableViewCell.galleryHeight = 240
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
