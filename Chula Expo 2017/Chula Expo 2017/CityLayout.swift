//
//  CityLayout.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class CityLayout: UICollectionViewLayout {
    
    var numberOfColumns = 1
    var cellPadding: CGFloat = 6.0

    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight:CGFloat  = 85
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
//        print("insetleft\(insets.left)")
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    fileprivate var screenHeight: CGFloat{
        return collectionView!.bounds.height - 49
    }
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = (contentWidth - (cellPadding * CGFloat(numberOfColumns + 1))) / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                
                    xOffset.append((CGFloat(column) * (columnWidth + cellPadding)) + cellPadding)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: cellPadding, count: numberOfColumns)
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                let width = columnWidth
                let numOfItem = CGFloat(collectionView!.numberOfItems(inSection: 0))
                var height = CGFloat(0)
                switch numberOfColumns {
                case 1:
                    height = max((screenHeight - ((numOfItem + 1) * cellPadding)) / (numOfItem / CGFloat(numberOfColumns)), CGFloat(85))
                case 2:
                    height = CGFloat(100)
                case 3:
                    height = width
                default:
                    height = CGFloat(0)
                }
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
            //  let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
              
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height + (1 * cellPadding)
                
                column = column >= (numberOfColumns - 1) ? 0 : (column+1)
            }

        }
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes  in cache {
            if attributes.frame.intersects(rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    func clearCache(){
        cache = []
    }
    
}
