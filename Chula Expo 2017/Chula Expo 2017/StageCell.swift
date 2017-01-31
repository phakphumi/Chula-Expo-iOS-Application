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
    var toRound: NSSet?{
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
        }
        
        if let stageNo = stage{
            if stageNo == 1{
                timeLabel.text = "STAGE 1"
                stageNameLabel.text = "Grand AUD"
            }
            if stageNo == 2{
                timeLabel.text = "STAGE 2"
                stageNameLabel.text = "Sala Phrakiew"
            }
            if stageNo == 3{
                timeLabel.text = "STAGE 3"
                stageNameLabel.text = "City Main Stage"
            }
        }
    }
}
