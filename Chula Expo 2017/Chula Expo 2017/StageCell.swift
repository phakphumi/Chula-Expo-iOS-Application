//
//  StageCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class StageCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var stageEventNameLabel: UILabel!
    
    var name: String?{
        didSet{
            updateUI()
        }
    }
    var startTime: NSDate?{
        didSet{
            updateUI()
        }
    }
    var endTime: NSDate?{
        didSet{
            updateUI()
        }
    }
    var stage: Int?{
        didSet{
            updateUI()
        }
    }
    private func updateUI(){
        // reset
        timeLabel.text=nil
        stageNameLabel.text = nil
        stageEventNameLabel.text = nil
        if let stageEventName = name{
            stageEventNameLabel.text = stageEventName
        }
        if let stageStartTime = startTime{
            if let stageEndTime = endTime{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "H:mm"
                let sTime = dateFormatter.string(from: stageStartTime as Date)
                let eTime = dateFormatter.string(from: stageEndTime as Date)
                timeLabel.text = "\(sTime) - \(eTime)"
            }
        }
        if let stageNo = stage{
            if stageNo == 1{
                timeLabel.text = "Stage 1 • " + timeLabel.text!
                stageNameLabel.text = "Grand Auditorium"
            }
            if stageNo == 2{
                timeLabel.text = "Stage 2 • " + timeLabel.text!
                stageNameLabel.text = "Sala Phrakiew Common"
            }
            if stageNo == 3{
                timeLabel.text = "Stage 3 • " + timeLabel.text!
                stageNameLabel.text = "City Main Stage"
            }
        }
    }
}
