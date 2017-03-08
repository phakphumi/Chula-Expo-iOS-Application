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
            updateAllFrameWithNewData()
        }
    }
    var topicLabelText: [String]?{
        didSet{
            
            initIfReady()
            updateAllFrameWithNewData()
        }
    }

    var descLabelText: [String]?{
        didSet{
            
            initIfReady()
            updateAllFrameWithNewData()
        }
    }

    var isInit = false
    
    var imageNameDemo = ["defaultBig", "defaultBig"]
    var topicLabelTextDemo = ["Welcome to Chula Expo 2017", "Welcome to Chula Expo 2017"]
    var descLabelTextDemo = ["15-19 March 2017 • Chulalongkorn University", "15-19 March 2017 • Chulalongkorn University"]
    
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
        createPageIndicator()
        
    }
    
    func initIfReady() {
        
        if imageName != nil && descLabelText != nil && topicLabelText != nil && isInit == false{
           
               setupData()
            }
//            createPageIndicator()
    }

    func setupData() {
        
        frameViewControllers.removeAll()
        isInit = true
        for index in 0..<(imageName?.count ?? 0) {
        
        let frameViewController = SlideshowFrameViewController()
        setSlideshowPropoties(frameViewController: frameViewController, atIndex: index)
        frameViewControllers.append(frameViewController)
        }
    
        if frameViewControllers.count > 0 {
            
            setViewControllers([frameViewControllers[0]], direction: .forward, animated: true, completion: nil)
            pageControl.numberOfPages = frameViewControllers.count
            
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(SlideshowPageViewController.nextViewController), userInfo: nil, repeats: false)
            
        }else{
            //
            
            for i in 0..<imageNameDemo.count {
                
                let frameViewController = SlideshowFrameViewController()
                frameViewController.imageName = imageNameDemo[i]
                frameViewController.topicLabelText = topicLabelTextDemo[i]
                frameViewController.descLabelText = descLabelTextDemo[i]
                frameViewController.frameIndex = i
                frameViewControllers.append(frameViewController)
                
            }
            
            
            setViewControllers([frameViewControllers[0]], direction: .forward, animated: true, completion: nil)
            pageControl.numberOfPages = frameViewControllers.count
            
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(SlideshowPageViewController.nextViewController), userInfo: nil, repeats: false)
        
        }
    }

    func updateAllFrameWithNewData(){
        
        if imageName?.count == topicLabelText?.count && imageName?.count == descLabelText?.count && imageName?.count != 0{
            
            frameViewControllers.removeAll()
            for index in 0..<(imageName?.count ?? 0) {
                
                let frameViewController = SlideshowFrameViewController()
                setSlideshowPropoties(frameViewController: frameViewController, atIndex: index)
                frameViewControllers.append(frameViewController)
            }
            frameIndex = 0
            pageControl.numberOfPages = frameViewControllers.count
            timer.invalidate()
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
        
        let currentFrameIndex = frameIndex
        
//        let currentImageFrameName = (viewController as! SlideshowFrameViewController).imageName
//        let currentImageIndex = imageName?.index(of: currentImageFrameName!)
//        let frameViewController = SlideshowFrameViewController()
        
        if currentFrameIndex < frameViewControllers.count - 1 {
            
            return frameViewControllers[currentFrameIndex + 1]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: currentImageIndex! + 1)
            
        } else {
            
            return frameViewControllers[0]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: 0)
            
        }
        
//        return SlideshowFrameViewController()
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentFrameIndex = frameIndex
//        let currentImageFrameName = (viewController as! SlideshowFrameViewController).imageName
//        let currentImageIndex = imageName?.index(of: currentImageFrameName!)
        
//        let frameViewController = SlideshowFrameViewController()
        
        if currentFrameIndex > 0 {
            
            
            if currentFrameIndex - 1 < frameViewControllers.count{
               return frameViewControllers[currentFrameIndex - 1]
            }
            else {
                return frameViewControllers[0]
            }
            
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: currentImageIndex! - 1)
            
        } else {
            
            return frameViewControllers[frameViewControllers.count - 1]
//            setSlideshowPropoties(frameViewController: frameViewController, atIndex: (imageName?.count)! - 1)
            
        }
        
//        return frameViewController
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        timer.invalidate()
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            let currentFrameIndex = (pageViewController.viewControllers?.first as! SlideshowFrameViewController).frameIndex
//            let currentImageIndex = imageName?.index(of: currentImageFrameName!)
        
            frameIndex = currentFrameIndex
            
//            if frameIndex > imageName!.count{
//                frameIndex = 0
//            }
            
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
        
        if frameIndex < frameViewControllers.count - 1 {
         
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
        frameViewController.frameIndex = atIndex
        
    }
    
    func createPageIndicator() {
        
        pageControl = UIPageControl()
        pageControl = UIPageControl(frame: CGRect(x: self.view.center.x - self.view.bounds.width / 2, y: self.view.bounds.height - 10, width: self.view.bounds.width, height: 6))
        pageControl.numberOfPages = (imageName?.count) ?? 0
        
        self.view.addSubview(pageControl)
        
    }

}
