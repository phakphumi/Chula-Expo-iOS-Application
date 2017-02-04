//
//  FavoriteViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/3/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    var dateTimeList = [String]()
    var dates = [String]()
    var times = [[String]]()

    let dateTimePicker = UIPickerView()

    @IBOutlet var dateTimeField: UITextField!
    @IBOutlet var dateTimeFieldView: UIView!
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        self.view.insertSubview(blurEffectView, at: 0)
    
//        let blurEffect2 = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
//        blurEffectView2.frame = pickerView.bounds
//        
//        pickerView.insertSubview(blurEffectView2, at: 0)
        
        generateTimeList()
        
        dateTimeField.text = dateTimeList[0]
        
        dateTimePicker.delegate = self
        dateTimePicker.dataSource = self
        
        addPickerToolbar()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        dateTimeField.layer.borderWidth = 3
        dateTimeField.layer.borderColor = UIColor.white.cgColor
        dateTimeField.layer.cornerRadius = dateTimeField.frame.height / 2
        dateTimeField.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.layer.masksToBounds = true
        
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dateTimeList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dateTimeList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        dateTimeField.text = dateTimeList[row]
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dateTimeField.resignFirstResponder()
        
    }
    
    private func generateTimeList() {
        
        for (dateIndex, date) in dates.enumerated() {
            
            for (timeIndex, time) in times[dateIndex].enumerated() {
                
                dateTimeList.append("\(date) \(time)")
                
            }
            
        }
        
    }
    
    private func addPickerToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(FavoriteViewController.pickerDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        dateTimeField.inputAccessoryView = toolbar
        dateTimeField.inputView = dateTimePicker
        
    }
    
    func pickerDoneButton() {
        
        dateTimeField.resignFirstResponder()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
