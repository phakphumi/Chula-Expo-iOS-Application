//
//  AboutViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/17/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        aboutLabel.text = "จุฬาฯ เอ็กซ์โป\nจุฬาฯ 100 ปี นวัตกรรมคิดทำเพื่อสังคม\n\nChula Expo\nCU@100 toward greater\ninnovation for the society\n\n\nแนวคิดหลักในการจัดงาน\ninnovation  Social responsibility  Sustainability\n\nกลุ่มเป้าหมาย\nCU Family : ครอบครัวจุฬาฯ หมายถึง นิสิตปัจจุบัน นิสิตเก่า\nคณาจารย์และเจ้าหน้าที่ ที่มีความเกี่ยวข้องกับจุฬาฯ โดยตรง\nรวมทั้งนักเรียนที่มีมุ่งหมายจะเข้ามาเป็นส่วนหนึ่งของ\nจุฬาลงกรณ์มหาวิทยาลัย"
        // Do any additional setup after loading the view.
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
    @IBAction func back(_ sender: Any) {
        
    }

}
