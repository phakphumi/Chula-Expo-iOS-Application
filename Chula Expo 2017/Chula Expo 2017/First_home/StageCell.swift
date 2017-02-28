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
    var toRound: NSSet?{
        didSet{
            if let rounds = toRound{
                if let round = rounds.allObjects.first as! RoundData?{
                    let stageStartTime = round.startTime!
                    let stageEndTime = round.endTime!
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "H:mm"
                    let sTime = dateFormatter.string(from: stageStartTime as Date)
                    let eTime = dateFormatter.string(from: stageEndTime as Date)
                    timeLabel.text = "\(sTime) - \(eTime)"
                }
            } else {
                timeLabel.text = "แตะเพื่อดูกิจกรรมในช่วงเวลาอื่น"
            }
        }
    }
    var stage: Int?{
        didSet{
            if let stageNo = stage{
                if stageNo == 1{
                    stageNoLabel.text = "STAGE 1"
                    stageNameLabel.text = "เวทีหลัก"
                }
                if stageNo == 2{
                    stageNoLabel.text = "STAGE 2"
                    stageNameLabel.text = "หอประชุมใหญ่"
                }
                if stageNo == 3{
                    stageNoLabel.text = "STAGE 3"
                    stageNameLabel.text = "ศาลาพระเกี้ยว"
                }
            }

        }
    }
    private func updateUI(){
   
    }
    
}
