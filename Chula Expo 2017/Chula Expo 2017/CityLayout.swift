//
//  CityLayout.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class CityLayout: UICollectionViewLayout {

    fileprivate var cache = [UICollectionViewLayoutAttributes]()
//    for item in 0 ..<
//    let attributes = UICollectionViewLayoutAttributes(forCellWith: <#T##IndexPath#>)
    fileprivate var contentHeight:CGFloat  = 0.0
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        if cache.isEmpty {
            
        }
    }
    
}
