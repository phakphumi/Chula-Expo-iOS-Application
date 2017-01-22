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

    
    var imageAlbum = [UIImageView]()
    var numberOfInputImage = 0
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
        
    }
    
    private func clearImage() {
        
        for image in imageAlbum {
            
            image.image = nil
            
        }
        
    }
    
    func wasTapped(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        imageAlbum = [image1, image2, image3, image4,
                      image5, image6]
        
        setImageTag()
        clearImage()
        
    }
    
    override func layoutSubviews() {
            
            GalleryTableViewCell.galleryHeight = 80
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
