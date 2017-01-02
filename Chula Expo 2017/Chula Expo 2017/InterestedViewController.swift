//
//  InterestedViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/26/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class InterestedViewController: UIViewController {

    var movingView = [UIView]()
    var imageView = [UIImageView]()
    var imageLabel = [UILabel]()
    var baseCenterMovingView = [CGFloat]()
    var selectedObject = [Bool]()
    
    let baseImageViewTag = 100
    let baseUICoverTag = 1000
    let image = [
                    UIImage(named: "technology.jpg"),
                    UIImage(named: "engineering.jpg"),
                    UIImage(named: "medical.jpg"),
                    UIImage(named: "architecture.jpg")
                ]
    let textLabel = [
                        "Technology",
                        "Engineering",
                        "Medical",
                        "Architecture"
                    ]
    
    var descText = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
                    "dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it",
                    "to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
                    "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing"]
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var descLabel: UILabel!
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        //Begin, create confirm alert when user click done button
        let confirm = UIAlertController(title: "Are you sure to done this process?", message: "You can't come back later", preferredStyle: UIAlertControllerStyle.alert)
        
        confirm.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.performSegue(withIdentifier: "toTabBarController", sender: self) //if user click on Yes button segue to Tab Bar Controller
            
        }))
        
        confirm.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        //End
        
        self.present(confirm, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGradientNavBar()
        
        createTopicSlidebar()
        
        descLabel.sizeToFit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func wasTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        print("tap")
        let tappedMovingView = gestureRecognizer.view!
        let tappedMovingViewIndex = movingView.index(of: tappedMovingView)!
        
        let tappedImageView = tappedMovingView.viewWithTag(tappedMovingViewIndex + baseImageViewTag)!
        
        if selectedObject[tappedMovingViewIndex] {
            
            selectedObject[tappedMovingViewIndex] = false
            
            //Begin, remove black cover
            tappedMovingView.viewWithTag(tappedMovingViewIndex + baseUICoverTag)?.removeFromSuperview()
            //End
            
        } else {
            
            //Begin, define checkmark img scale width and height by 12% height's screen
            let checkmarkScale = self.view.bounds.height * 0.12
            //End, define
            
            selectedObject[tappedMovingViewIndex] = true
            
            let coverView = UIView(frame: CGRect(x: 0, y: 0, width: tappedImageView.frame.width, height: tappedImageView.frame.height))
            coverView.tag = tappedMovingViewIndex + baseUICoverTag
            
            //Begin, create black cover
            let blackCover = UIView(frame: CGRect(x: 0, y: 0, width: coverView.frame.width, height: coverView.frame.height))
            blackCover.backgroundColor = UIColor.black
            blackCover.layer.opacity = 0.7
            blackCover.layer.cornerRadius = tappedImageView.frame.width / 2
            blackCover.layer.masksToBounds = true
            coverView.addSubview(blackCover)
            //End,
            
            //Begin, create a checkmark on blackcover
            let checkmark = UIImageView(frame: CGRect(x: coverView.frame.width / 2 - checkmarkScale / 2, y: coverView.frame.height / 2 - checkmarkScale / 2, width: checkmarkScale, height: checkmarkScale))
            checkmark.image = UIImage(named: "checkmark.png")
            checkmark.contentMode = UIViewContentMode.scaleAspectFit
            checkmark.layer.opacity = 0.9
            coverView.addSubview(checkmark)
            //End
            
            tappedMovingView.addSubview(coverView)
            
        }
        
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let distanceToChangeTopic = self.view.bounds.width * 0.26
        
        //Begin, define movingView scale with height 37.5% of screen and making top margin 17.25% from top of screen
        let movingViewHeight = self.view.bounds.height * 0.375
        let movingViewTopMargin = self.view.bounds.height * 0.1725
        //End, define
        
        let translation = gestureRecognizer.translation(in: view)
        
        let touchedMovingView = gestureRecognizer.view! // get moving object
        
        for i in 0..<4 {
            
            movingView[i].center = CGPoint(x: baseCenterMovingView[i] + translation.x, y: movingViewTopMargin + movingViewHeight / 2) // move the moving object
            
            let xFromCenter = movingView[i].center.x - self.view.bounds.width / 2 // check how far from center
            
            //Begin, scale to small the movingView when moving more than 25
            let scale = min(pow(abs(25 / xFromCenter),1/4), 1)
            
            let stretch = CGAffineTransform(scaleX: scale, y: scale)
            
            movingView[i].transform = stretch
            //End
            
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            let currentViewIndex = movingView.index(of: touchedMovingView)!
            
            if touchedMovingView.center.x > self.view.bounds.width - distanceToChangeTopic && currentViewIndex != 0 {
                
                descLabel.text = descText[currentViewIndex - 1]
                
                movingView[currentViewIndex].isUserInteractionEnabled = false
                movingView[currentViewIndex - 1].isUserInteractionEnabled = true
                
                //Begin, moving right
                let xPreviousViewFromCenter = movingView[currentViewIndex-1].center.x - self.view.bounds.width / 2 // check how next view far from center
                
                for i in 0..<4 {
                    
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.baseCenterMovingView[i] = self.movingView[i].center.x - xPreviousViewFromCenter
                        self.movingView[i].center.x = self.baseCenterMovingView[i]
                        
                        let xFromCenter = self.movingView[i].center.x - self.view.bounds.width / 2 // check how far from center
                        
                        //Begin, scale to small the movingView when moving more than 25
                        let scale = min(pow(abs(25 / xFromCenter),1/4), 1)
                        
                        let stretch = CGAffineTransform(scaleX: scale, y: scale)
                        
                        self.movingView[i].transform = stretch
                        //End
                        
                    })
                    
                }
                //End
                
            } else if touchedMovingView.center.x < distanceToChangeTopic && currentViewIndex+1 != movingView.count {
                
                descLabel.text = descText[currentViewIndex + 1]
                
                movingView[currentViewIndex].isUserInteractionEnabled = false
                movingView[currentViewIndex + 1].isUserInteractionEnabled = true
                
                //Begin, moving left
                let xNextViewFromCenter = movingView[currentViewIndex+1].center.x - self.view.bounds.width / 2 // check how next view far from center
                
                for i in 0..<4 {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.baseCenterMovingView[i] = self.movingView[i].center.x - xNextViewFromCenter
                        self.movingView[i].center.x = self.baseCenterMovingView[i]
                        
                        let xFromCenter = self.movingView[i].center.x - self.view.bounds.width / 2 // check how far from center
                        
                        //Begin, scale to small the movingView when moving more than 25
                        let scale = min(pow(abs(25 / xFromCenter),1/4), 1)
                        
                        let stretch = CGAffineTransform(scaleX: scale, y: scale)
                        
                        self.movingView[i].transform = stretch
                        //End
                        
                    })
                    
                }
                //End
                
            } else {
                
                //Begin, not moving
                for i in 0..<4 {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.movingView[i].center.x = self.baseCenterMovingView[i]
                        
                        let xFromCenter = self.movingView[i].center.x - self.view.bounds.width / 2 // check how far from center
                        
                        //Begin, scale to small the movingView when moving more than 25
                        let scale = min(pow(abs(25 / xFromCenter),1/4), 1)
                        
                        let stretch = CGAffineTransform(scaleX: scale, y: scale)
                        
                        self.movingView[i].transform = stretch
                        //End
                        
                    })
                    
                }
                //End
                
            }
            
        }
        
    }
    
    
    func createGradientNavBar() {
        
        //Begin, define gradient color shade from RGB(202,92,171) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.8, green: 0.36, blue: 0.67, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        var navIncludeStatFrame = navigationController!.navigationBar.bounds
        navIncludeStatFrame.size.height += 20
        gradientLayer.frame = navIncludeStatFrame
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //End
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(gradientImage, for: UIBarMetrics.default)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func createTopicSlidebar() {
        print(self.view.bounds.height)
        
        //Begin, define movingView scale with width 56% and height 37.5% of screen and making top margin 17.25% from top of screen
        let movingViewWidth = self.view.bounds.width * 0.56
        let movingViewHeight = self.view.bounds.height * 0.375
        let movingViewTopMargin = self.view.bounds.height * 0.1725
        //End, define
        
        let xFirstPosition = self.view.bounds.width / 2 - movingViewWidth / 2
        
        for i in 0..<4 {
            
            selectedObject.append(false)
            movingView.append(UIView(frame: CGRect(x: xFirstPosition + CGFloat(i) * self.view.bounds.width / 2, y: movingViewTopMargin, width: movingViewWidth, height: movingViewHeight)))
            baseCenterMovingView.append(movingView[i].center.x)
            
            //Begin, define imageView scale by 100% of movingViewWidth and 84% of movingViewHeight
            let imageViewWidth = movingView[i].frame.width
            let imageViewHeight = movingView[i].frame.height * 0.84
            //End, define
            
            //Begin, create image view with the circle mask
            imageView.append(UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)))
            
            imageView[i].image = image[i]
            
            imageView[i].tag = baseImageViewTag + i
            
            imageView[i].contentMode = UIViewContentMode.scaleAspectFit
            
            imageView[i].layer.cornerRadius = imageView[i].frame.width / 2
            
            imageView[i].layer.masksToBounds = true
            //End
            
            //Begin, define imageLabel scale by 100% of movingViewWidth and 8% of movingViewHeight and also imageLabelTopMargin(Space between image and label) by 92% from the top of movingViewHeight
            let imageLabelWidth = movingView[i].bounds.width
            let imageLabelHeight = movingView[i].bounds.height * 0.08
            let imageLabelTopMargin = movingView[i].bounds.height * 0.92
            //End, define
            
            //Begin, create text label below the image
            imageLabel.append(UILabel(frame: CGRect(x: 0, y: imageLabelTopMargin, width: imageLabelWidth, height: imageLabelHeight)))
            
            imageLabel[i].textAlignment = NSTextAlignment.center
            
            imageLabel[i].font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
            
            imageLabel[i].text = textLabel[i]
            //End
            
            movingView[i].addSubview(imageView[i])
            
            movingView[i].addSubview(imageLabel[i])
            
            let xFromCenter = movingView[i].center.x - self.view.bounds.width / 2 // check how far from center
            
            //Begin, scale to small the movingView when moving more than 25
            let scale = min(pow(abs(25 / xFromCenter),1/4), 1)
            
            let stretch = CGAffineTransform(scaleX: scale, y: scale)
            
            movingView[i].transform = stretch
            //End
            
            view.addSubview(movingView[i])
            
            movingView[i].isUserInteractionEnabled = false
            
            //Begin, create gestureRecognizer to moving the object
            let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(InterestedViewController.wasDragged(gestureRecognizer:)))
            movingView[i].addGestureRecognizer(dragGestureRecognizer)
            //End

            
            //Begin, create tap gestureRecognizer to select item
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            movingView[i].addGestureRecognizer(tapGestureRecognizer)
            //End
            
        }
        
        movingView[0].isUserInteractionEnabled = true
        
    }
    
}
