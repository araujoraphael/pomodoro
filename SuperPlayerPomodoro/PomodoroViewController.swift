//
//  PomodoroViewController.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/11/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

@objc protocol PomodoroDelegate{
    optional func pomodoroFinished()
    optional func pomodoroTimeUpdated(minutes: UInt8, seconds: UInt8)
}

class PomodoroViewController: UIViewController {
    var pomodoro : RLMPomodoro = RLMPomodoro()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var delegate:PomodoroDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start(time: Int) {
        pomodoro = RLMPomodoro()
        pomodoro.initialTimeInterval = time;
        pomodoro.currentState = RLMPomodoro.PomodoroState.pomodoroStateRunning
        let aSelector : Selector = "updatePomodoroTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func stop(withState: RLMPomodoro.PomodoroState) {
        pomodoro.currentState = withState
        pomodoro.stoppedAt = NSDate()
        pomodoro.stoppedAtStr = PomodoroUtils.getFriendlyStringFromDate(pomodoro.stoppedAt, dateFormat: "yyyy-MM-dd", timeZone: NSTimeZone.systemTimeZone().name)
        pomodoro.save()
        timer.invalidate()
    }
    
    func updatePomodoroTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        let minutesLeft = UInt8(pomodoro.initialTimeInterval-1) - minutes
        let secondsLeft = 59 - seconds
        
        pomodoro.elapsedTime = Int(minutes * 60 + seconds + 1)
        delegate?.pomodoroTimeUpdated!(minutesLeft, seconds: secondsLeft)
        if(minutesLeft == 0 && secondsLeft == 0) {
            self.stop(RLMPomodoro.PomodoroState.pomodoroStateFinished)
            delegate?.pomodoroFinished!()
        }
    }
}
