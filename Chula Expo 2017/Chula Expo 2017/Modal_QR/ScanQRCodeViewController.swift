//
//  ScanQRCodeViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/27/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var qrCodeFrameView: UIView!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.backgroundColor = UIColor.blue.cgColor
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            
        } catch {
            
            return
            
        }
        
        if captureSession.canAddInput(videoInput) {
            
            captureSession.addInput(videoInput)
            
        } else {
        
            failed()
            
            return
            
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            
            captureSession.addOutput(metadataOutput)
          
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
        } else {
            
            failed()
            
            return
            
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.qrCodeFrameView.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.qrCodeFrameView.layer.addSublayer(previewLayer)
        
        self.view.bringSubview(toFront: closeButton)
        
    }

    func failed() {
        
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
        
        captureSession = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if captureSession?.isRunning == false {
            
            captureSession.startRunning()
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            
            captureSession.stopRunning()
            
        }
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            found(code: readableObject.stringValue)
            
        } else {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    func found(code: String) {
    
        let seperatedCode = code.components(separatedBy: "/")
        print(seperatedCode)
        
        if seperatedCode.count >= 5 {
            
            let domainName = seperatedCode[2]
            
            print(domainName)
            
            if domainName == "staff.chulaexpo.com" {
                
                let activityId = seperatedCode[5]
                
                print(activityId)
                
                self.dismiss(animated: true, completion: nil)
                
                return
                
            }
            
        }
        
        let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ไม่พบข้อมูลกิจกรรมนี้ใน Application", preferredStyle: UIAlertControllerStyle.alert)
        
        confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (alert) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(confirm, animated: true, completion: nil)
        
//        UIApplication.shared.openURL(URL(string: code)!)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
        
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
