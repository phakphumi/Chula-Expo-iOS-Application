//
//  GalleryViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/17/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class GalleryViewController: UIPageViewController, UIPageViewControllerDataSource {

//    var imageName = [String]()

    var images = [String]()
    var currentImageIndex: Int = 0
    var imageFrameControllers = [ImageFrameViewController]()
    
    let appearance = UIPageControl.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        self.view.backgroundColor = UIColor.black
        
        for index in 0..<images.count{
            let frameViewController = ImageFrameViewController()
            frameViewController.imageView.imageFromServerURL(urlString: images[index])
            frameViewController.frameIndex = index
            imageFrameControllers.append(frameViewController)
        }
        
        
        
        setViewControllers([imageFrameControllers[currentImageIndex]], direction: .forward, animated: false, completion: nil)
     
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GalleryViewController.wasTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GalleryViewController.wasDrag(gestureRecognizer:)))
        self.view.addGestureRecognizer(dragGestureRecognizer)
        
    }
    
    func wasTap() {
        
        self.dismiss(animated: false, completion: nil)
        
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
//         touchedMovingView.transform = CGAffineTransform(scaleX: -(abs(translation.y)), y: -(abs(translation.y)))
        print( (abs(translation.y)))
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
        return images.count

    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return currentImageIndex
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        print("current = \(currentImageIndex)")
        print("after")
        let viewControllerIndex = (viewController as! ImageFrameViewController).frameIndex
        if viewControllerIndex < images.count - 1 {
            
            return imageFrameControllers[viewControllerIndex + 1]
            
        }
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        print("current = \(currentImageIndex)")
        print("before")
        let viewControllerIndex = (viewController as! ImageFrameViewController).frameIndex
        if viewControllerIndex > 0 {
            
            return imageFrameControllers[viewControllerIndex - 1]
            
        }
        
        return nil
        
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [AnyObject],
                            transitionCompleted completed: Bool)
    {
        if finished && completed{
            if let curPage = pageViewController.viewControllers?.first as? ImageFrameViewController{
                currentImageIndex = curPage.frameIndex
            }
        }
    }
}
