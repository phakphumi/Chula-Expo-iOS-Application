//
//  StageCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class StageCell: UITableViewCell {

    @IBOutlet weak var stageNoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var stageEventNameLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    var name: String?{
        didSet{
            cardStyle(background: background)
            stageEventNameLabel.text = name
        }
    }
    var time: String?{
        didSet{
            if let timeT = time{
                timeLabel.text = timeT
            }
        }
    }
    var stage: Int?{
        didSet{
            if let stageNo = stage{
                if stageNo == 1{
                    stageNoLabel.text = "เวทีกลาง"
                    stageNameLabel.text = "CENTRAL"
                }
                if stageNo == 2{
                    stageNoLabel.text = "หอประชุมใหญ่"
                    stageNameLabel.text = "GRAND"
                }
                if stageNo == 3{
                    stageNoLabel.text = "ศาลาพระเกี้ยว"
                    stageNameLabel.text = "CU@100"
                }
            }

        }
    }
    private func updateUI(){
   
    }
    
}
