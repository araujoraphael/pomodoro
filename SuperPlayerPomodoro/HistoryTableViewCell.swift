//
//  HistoryTableViewCell.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/13/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var pastTimeLabel: UILabel!
    @IBOutlet weak var stoppedTimeLabel: UILabel!
    
    var _pomodoro:RLMPomodoro? = nil
    var pomodoro : RLMPomodoro?{
        get {
            return _pomodoro
        }
        set (pomodoro) {
            _pomodoro = pomodoro
            self.currentStatusLabel!.text = _pomodoro!.currentState.description
            self.stoppedTimeLabel!.text = PomodoroUtils.getFriendlyTimeStringFormatFromSeconds(_pomodoro!.elapsedTime)
            self.pastTimeLabel!.text = self.friendlyStoppedTime()
            
        }
    }
    
    func friendlyStoppedTime() -> String {
        var friendlyStoppedTime = ""
        let currentTime = NSDate()
        let pomodoroStoppedAt = self.pomodoro?.stoppedAt
        let differenceInSeconds = PomodoroUtils.differenceInSecondsOfTwoDates(pomodoroStoppedAt!, date2: currentTime)
        
        if(differenceInSeconds < 60) {
            friendlyStoppedTime = "\(differenceInSeconds) second(s) ago"
        } else {
            let differenceInMinutes = PomodoroUtils.differenceInMinutesOfTwoDates(pomodoroStoppedAt!, date2: currentTime)
            
            if(differenceInMinutes < 60) {
                friendlyStoppedTime = "\(differenceInMinutes) minute(s) ago"
            } else {
                let differenceInHours = PomodoroUtils.differenceInHoursOfTwoDates(pomodoroStoppedAt!, date2: currentTime)

                if(differenceInHours < 3) {
                    friendlyStoppedTime = "\(differenceInHours) hour(s) ago"
                } else {
                    let friendlyHourAndMinute = PomodoroUtils.getFriendlyStringFromDate(pomodoroStoppedAt!, dateFormat: "h:mm a", timeZone: NSTimeZone.systemTimeZone().name)
                    friendlyStoppedTime = friendlyHourAndMinute
                }
            }
        }
        
        return friendlyStoppedTime
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
