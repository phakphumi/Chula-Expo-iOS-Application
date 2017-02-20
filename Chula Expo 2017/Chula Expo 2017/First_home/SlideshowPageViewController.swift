//
//  SlideshowPageViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/18/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class SlideshowPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var imageName: [String]?{
        didSet{
            initIfReady()
        }
    }
    var topicLabelText: [String]?{
        didSet{
            initIfReady()
        }
    }

    var descLabelText: [String]?{
        didSet{
            initIfReady()
        }
    }

    var isInit = false
    
//    var imageName = ["slideShow1.jpg", "slideShow2.jpg"]
//    var topicLabelText = ["Welcome to Chula Expo 2017", "Chula Expo Special Event"]
//    var descLabelText = ["9:41-10:41 • Main auditorium Building 3", "13:00-14:00 • Main auditorium"]
    
    var timer = Timer()
    var frameViewControllers = [SlideshowFrameViewController]()
    var frameIndex = 0
    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.frame = CGRect(x: 0, y: 0, width: 375, height: 220)
        delegate = self
        dataSource = self
        
        
    }
    
    func initIfReady() {
        
        if imageName != nil && descLabelText != nil && topicLabelText != nil && isInit == false{
            
            isInit = true
            for index in 0..<(imageName?.count ?? 0) {
                
                let frameViewController = SlideshowFrameViewController()
                setSlideshowPropoties(frameViewController: frameViewController, atIndex: index)
                frameViewControllers.append(frameViewController)
            }
            
//            let viewController = [frameViewController]
            
            setViewControllers([frameViewControllers[0]], direction: .forward, animated: true, completion: nil)
            
            createPageIndicator()
            
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(SlideshowPageViewController.nextViewController), userInfo: nil, repeats: false)
            
        }
        
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)

    }

//    private func setupPageControl() {
//        
//        let appearance = UIPageControl.appearance()
//        appearance.pageIndicatorTintColor = UIColor.gray
//        appearance.currentPageIndicatorTintColor = UIColor.white
//        appearance.backgroundColor = UIColor.black.withAlphaComponent(0)
//        
//    }
//    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        
//        setupPageControl()
//        
//        return imageName.count
//        
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        
//        return 0
//        
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentImageFrameName = (viewController as! SlideshowFrameViewController).imageName
        let currentImageIndex = imageName?.index(of: currentImageFrameName!)
//        let frameViewController = SlideshowFrameViewController()
        
        if currentImageIndex! < (imageName?.count)! - 1 {
            
            return frameViewControllers[currentImageIndex! + 1]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: currentImageIndex! + 1)
            
        } else {
            
            return frameViewControllers[0]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: 0)
            
        }
        
//        return SlideshowFrameViewController()
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentImageFrameName = (viewController as! SlideshowFrameViewController).imageName
        let currentImageIndex = imageName?.index(of: currentImageFrameName!)
        
//        let frameViewController = SlideshowFrameViewController()
        
        if currentImageIndex! > 0 {
            
            return frameViewControllers[currentImageIndex! - 1]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: currentImageIndex! - 1)
            
        } else {
            
            return frameViewControllers[(imageName?.count)! - 1]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: (imageName?.count)! - 1)
            
        }
        
//        return frameViewController
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        timer.invalidate()
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            let currentImageFrameName = (pageViewController.viewControllers?.first as! SlideshowFrameViewController).imageName
            let currentImageIndex = imageName?.index(of: currentImageFrameName!)
        
            frameIndex = currentImageIndex!
            
            self.pageControl.currentPage = frameIndex
            if finished{
                print("add timer")
                timer.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(SlideshowPageViewController.nextViewController), userInfo: nil, repeats: false)
            }

        }
        
    }
    
    func autoSkip(ready: Bool){
        
        if ready{
            
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(SlideshowPageViewController.nextViewController), userInfo: nil, repeats: false)
        }
    }
    
    func nextViewController() {
        
        if frameIndex < (imageName?.count)! - 1 {
         
            frameIndex += 1
            
        } else {
            
            frameIndex = 0
            
        }
        
//        let frameViewController = SlideshowFrameViewController()
        
//        setSlideshowPropoties(frameViewController: frameViewController, atIndex: frameIndex)
        
        let viewController = [frameViewControllers[frameIndex]]
            
        self.setViewControllers(viewController, direction: .forward, animated: true, completion: SlideshowPageViewController.autoSkip(self))
        
        self.pageControl.currentPage = frameIndex
        
    }
    
    func setSlideshowPropoties(frameViewController: SlideshowFrameViewController, atIndex: Int) {
        
        frameViewController.imageName = imageName?[atIndex]
        frameViewController.topicLabelText = topicLabelText?[atIndex]
        frameViewController.descLabelText = descLabelText?[atIndex]
        
    }
    
    func createPageIndicator() {
        
        pageControl = UIPageControl(frame: CGRect(x: self.view.center.x - self.view.bounds.width / 2, y: self.view.bounds.height - 10, width: self.view.bounds.width, height: 6))
        pageControl.numberOfPages = (imageName?.count) ?? 0
        
        self.view.addSubview(pageControl)
        
    }

}
