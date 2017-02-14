//
//  DocumentTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var documentView: UIView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    var pdfUrl: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        documentView.layer.borderWidth = 2
        documentView.layer.borderColor = UIColor(red: 0.694, green: 0.22, blue: 0.227, alpha: 1).cgColor
        documentView.layer.cornerRadius = 4
        documentView.layer.masksToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DocumentTableViewCell.wasTap))
        documentView.addGestureRecognizer(tapGestureRecognizer)
        
        documentView.isUserInteractionEnabled = true
        
    }
    
    func wasTap() {
        
        if pdfUrl == "" {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "กิจกรรมนี้ไม่มีเอกสารประกอบ", preferredStyle: UIAlertControllerStyle.alert)
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil))
            
            let parentVC = self.parentViewController!
            parentVC.present(confirm, animated: true, completion: nil)
            
        } else {
            
            UIApplication.shared.openURL(URL(string: pdfUrl)!)
            
        }
        
    }

}
