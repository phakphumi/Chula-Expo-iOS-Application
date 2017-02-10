//
//  BookTableViewCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookmarkButton: UIButton!{
        didSet{
            layoutBookmarkButton()
        }
    }
    
    @IBOutlet weak var Bookingbutton: UIButton!{
        didSet{
            layoutBookingButton()
        }
    }
    
    func layoutBookmarkButton()
    {
        let imageBounds = bookmarkButton.imageView!.bounds
        let titleBounds = bookmarkButton.titleLabel!.bounds
        let totalHeight = imageBounds.height + 8 + titleBounds.height
        
        bookmarkButton.imageEdgeInsets = UIEdgeInsets(
            top:  -(totalHeight - imageBounds.height),
            left: (bookmarkButton.frame.width/2)-(imageBounds.width/2),
            bottom: 0,
            right: 0
        )
        bookmarkButton.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: (bookmarkButton.frame.width/2)-(titleBounds.width/2)-(imageBounds.width),
            bottom: -(totalHeight - titleBounds.height),
            right: 0
        )
//        bookmarkButton.backgroundColor = UIColor.blue
    }
    
    func layoutBookingButton()
    {
        let imageBounds = Bookingbutton.imageView!.bounds
        let titleBounds = Bookingbutton.titleLabel!.bounds
        let totalHeight = imageBounds.height + 8 + titleBounds.height
        
        Bookingbutton.imageEdgeInsets = UIEdgeInsets(
            top:  -(totalHeight-imageBounds.height),
            left: (Bookingbutton.frame.width/2)-(imageBounds.width/2),
            bottom: 0,
            right: 0
        )
        Bookingbutton.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: (Bookingbutton.frame.width/2)-(titleBounds.width/2)-(imageBounds.width),
            bottom: -(totalHeight-titleBounds.height),
            right:0
        )
//        Bookingbutton.backgroundColor = UIColor.brown
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        print("layoutSubviews cellwill \(bookmarkButton.frame.width)")
        layoutBookingButton()
        layoutBookmarkButton()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
