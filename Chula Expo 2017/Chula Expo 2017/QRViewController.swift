//
//  QRViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/11/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    var name: String!
    var schoolOrCompany: String!

    @IBOutlet var qrView: UIView!
    
    @IBAction func cancel(_ sender: UIButton) {
    
        dismiss(animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name = "Mark Zuckerburg"
        schoolOrCompany = "Havard University"
        
        createGradientLayer()
        
        createProfileImageView()
        
        createNameLabelView()
        
        createSchoolOrCompanyLabelView()
        
        createQRCodeImageView()
        
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
    
    func createQRCodeImageView() {
        
        let qrCodeImageViewWidthAndHeight = self.view.bounds.height * 0.40
        let qrCodeImageViewTopMargin = self.view.bounds.height * 0.405
        
        let qrCodeImageView = UIImageView(frame: CGRect(x: qrView.bounds.width / 2 - qrCodeImageViewWidthAndHeight / 2, y: qrCodeImageViewTopMargin, width: qrCodeImageViewWidthAndHeight, height: qrCodeImageViewWidthAndHeight))
        qrCodeImageView.image = #imageLiteral(resourceName: "temp_qrcode")
        
        qrView.addSubview(qrCodeImageView)
        
    }
    
    func createProfileImageView() {
        
        let imageViewWidthAndHeight = self.view.bounds.height * 0.18
        let imageViewTopMargin = self.view.bounds.height * 0.0653
        
        let imageProfileView = UIImageView(frame: CGRect(x: qrView.bounds.width / 2 - imageViewWidthAndHeight / 2, y: imageViewTopMargin, width: imageViewWidthAndHeight, height: imageViewWidthAndHeight))
        imageProfileView.image = #imageLiteral(resourceName: "mark_zuckerberg")
        imageProfileView.layer.cornerRadius = imageProfileView.bounds.height / 2
        imageProfileView.layer.borderColor = UIColor.white.cgColor
        imageProfileView.layer.borderWidth = 3
        imageProfileView.layer.masksToBounds = true
        
        qrView.addSubview(imageProfileView)
        
    }
    
    func createNameLabelView() {
        
        let nameLabelViewWidth = qrView.bounds.width
        let nameLabelViewHegiht = CGFloat(26)
        let nameLabelViewTopMargin = self.view.bounds.height * 0.255
        
        let nameLabelView = UILabel(frame: CGRect(x: qrView.bounds.width / 2 - nameLabelViewWidth / 2, y: nameLabelViewTopMargin, width: nameLabelViewWidth, height: nameLabelViewHegiht))
        nameLabelView.text = self.name
        nameLabelView.font = nameLabelView.font.withSize(22)
        nameLabelView.textAlignment = NSTextAlignment.center
        nameLabelView.textColor = UIColor.white
        nameLabelView.text = name
        
        qrView.addSubview(nameLabelView)
        
    }
    
    func createSchoolOrCompanyLabelView() {
        
        let schoolOrCompanyLabelViewWidth = qrView.bounds.width
        let schoolOrCompanyLabelViewHegiht = CGFloat(18)
        let schoolOrCompanyLabelViewTopMargin = self.view.bounds.height * 0.30
        
        let schoolOrCompanyLabelView = UILabel(frame: CGRect(x: qrView.bounds.width / 2 - schoolOrCompanyLabelViewWidth / 2, y: schoolOrCompanyLabelViewTopMargin, width: schoolOrCompanyLabelViewWidth, height: schoolOrCompanyLabelViewHegiht))
        schoolOrCompanyLabelView.text = self.schoolOrCompany
        schoolOrCompanyLabelView.font = schoolOrCompanyLabelView.font.withSize(14)
        schoolOrCompanyLabelView.textAlignment = NSTextAlignment.center
        schoolOrCompanyLabelView.textColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
        schoolOrCompanyLabelView.text = name
        
        qrView.addSubview(schoolOrCompanyLabelView)
        
    }
    
    func createGradientLayer() {
        
        //Begin, define gradient layer scale
        let gradientWidth: CGFloat = self.view.bounds.width * 0.88
        let gradientHeight: CGFloat = self.view.bounds.height * 0.36
        //End, define
        
        //Begin, define gradient color shade from RGB(210,116,184) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.82, green: 0.455, blue: 0.72, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientWidth, height: gradientHeight)
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        //End
        
        qrView.layer.insertSublayer(gradientLayer, at: 0)
        
    }

}
