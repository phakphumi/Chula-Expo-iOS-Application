//
//  GalleryTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/16/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet var galleryCollectionView: UICollectionView!
    @IBOutlet var galleryView: UIView!
    
    var images = [#imageLiteral(resourceName: "robot6"), #imageLiteral(resourceName: "robot9"), #imageLiteral(resourceName: "robot5"), #imageLiteral(resourceName: "robot12"), #imageLiteral(resourceName: "robot10"), #imageLiteral(resourceName: "robot11")]
    /*
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
     */
    
    var imageAlbum = [UIImageView]()
    
    /*private func setImageTag() {
        
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
        
    }*/
    
    func wasTapped(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        /*
        imageAlbum = [image1, image2, image3, image4,
                      image5, image6]
        
        
        setImageTag()
        clearImage() */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as UICollectionViewCell
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.image = images[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 50, height: 50)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
