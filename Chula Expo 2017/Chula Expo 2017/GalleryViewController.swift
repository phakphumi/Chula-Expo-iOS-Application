//
//  GalleryViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/17/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class GalleryViewController: UIPageViewController, UIPageViewControllerDataSource {

    var imageName = [String]()
    
    let appearance = UIPageControl.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        self.view.backgroundColor = UIColor.black
        
        let frameViewController = ImageFrameViewController()
        frameViewController.imageName = imageName.first
        let viewController = [frameViewController]
        
        setViewControllers(viewController, direction: .forward, animated: true, completion: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GalleryViewController.wasTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GalleryViewController.wasDrag(gestureRecognizer:)))
        self.view.addGestureRecognizer(dragGestureRecognizer)
        
    }
    
    func wasTap() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func getViewFrameCenter(myView : UIView) -> CGPoint {
        
        let xCenter = myView.frame.origin.x + myView.frame.width / 2
        let yCenter = myView.frame.origin.y + myView.frame.height / 2
        
        return CGPoint(x: xCenter, y: yCenter)

    }
    
    func wasDrag(gestureRecognizer: UIPanGestureRecognizer) {
        
        self.view.backgroundColor = nil
        
        setPageControlHidden(hidden: true)
        
        let translation = gestureRecognizer.translation(in: view)
        
        let touchedMovingView = gestureRecognizer.view! // get moving object
        
        touchedMovingView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {

            let viewFrameCenter = getViewFrameCenter(myView: touchedMovingView)
            
            let xDistanceToDismiss = self.view.bounds.width * 0.1
            let yDistanceToDismiss = self.view.bounds.height * 0.1

            let xFromCenter = abs(viewFrameCenter.x - self.view.bounds.width / 2) // check how far from center
            let yFromCenter = abs(viewFrameCenter.y - self.view.bounds.height / 2)
            
            if xFromCenter > xDistanceToDismiss || yFromCenter > yDistanceToDismiss {

                self.dismiss(animated: true, completion: nil)
                
            } else {
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.view.backgroundColor = UIColor.black
                    self.setPageControlHidden(hidden: false)
                    
                    touchedMovingView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                })
                
            }
            
        }
        
    }

    func setPageControlHidden (hidden: Bool)
    {
        for subView in self.view.subviews
        {
            if subView is UIPageControl
            {
                subView.isHidden = hidden
            }
        }
    }
    
    private func setupPageControl() {
        
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = nil
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        setupPageControl()
        
        return imageName.count
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentImageFrameName = (viewController as! ImageFrameViewController).imageName
        let currentImageIndex = imageName.index(of: currentImageFrameName!)
        
        if currentImageIndex! < imageName.count - 1 {
            
            let frameViewController = ImageFrameViewController()
            frameViewController.imageName = imageName[currentImageIndex! + 1]
            
            return frameViewController
            
        }
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentImageFrameName = (viewController as! ImageFrameViewController).imageName
        let currentImageIndex = imageName.index(of: currentImageFrameName!)
        
        if currentImageIndex! > 0 {
            
            let frameViewController = ImageFrameViewController()
            frameViewController.imageName = imageName[currentImageIndex! - 1]
            
            return frameViewController
            
        }
        
        return nil
        
    }

}
