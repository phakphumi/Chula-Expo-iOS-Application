//
//  GalleryTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/16/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            
            if let viewController = parentResponder as? UIViewController {
                
                return viewController
                
            }
            
        }
        
        return nil
        
    }
    
}


class GalleryTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet var galleryCollectionView: UICollectionView!
    @IBOutlet var galleryView: UIView!
    
    var images = [String]()
    /*
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
     */

    
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
    
    func wasTap() {
        
        let parentVC = self.parentViewController!
        
        if images.count > 0 {
        
            parentVC.performSegue(withIdentifier: "presentGallery", sender: parentVC)
        
        } else {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "กิจกรรมนี้ไม่มีรูปภาพประกอบ", preferredStyle: UIAlertControllerStyle.alert)
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil))
        
            parentVC.present(confirm, animated: true, completion: nil)
        
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GalleryTableViewCell.wasTap))
        galleryCollectionView.addGestureRecognizer(tapGestureRecognizer)

        galleryCollectionView.isUserInteractionEnabled = true
        
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
        
        imageView.imageFromServerURL(urlString: images[indexPath.row])
//        imageView.image = images[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width * 0.133333333, height: UIScreen.main.bounds.width * 0.133333333)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
