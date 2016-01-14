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
        pomodoro.save()
        timer.invalidate()
    }
    
    func updatePomodoroTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let minutesLeft = UInt8(pomodoro.initialTimeInterval-1) - minutes
        let secondsLeft = 59 - seconds
        
//        let strMinutes = String(format: "%02d", minutesLeft)
//        let strSeconds = String(format: "%02d", secondsLeft)
        

        pomodoro.elapsedTime = Int(minutes * 60 + seconds + 1)
        delegate?.pomodoroTimeUpdated!(minutesLeft, seconds: secondsLeft)
        if(minutesLeft == 0 && secondsLeft == 0) {
            self.stop(RLMPomodoro.PomodoroState.pomodoroStateFinished)
            delegate?.pomodoroFinished!()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
