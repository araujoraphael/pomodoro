//
//  FirstViewController.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/9/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, PomodoroDelegate {
    let pomodoroVC = PomodoroViewController()
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroVC.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startStopButtonTapped(sender: UIButton) {
        self.elapsedTimeLabel.text = "25:00"

        if(self.startStopButton.selected) {
            self.startStopButton.selected = false
            self.startStopButton.backgroundColor = UIColor.grayColor()
            self.pomodoroVC.stop(RLMPomodoro.PomodoroState.pomodoroStateStopped)
            self.elapsedTimeLabel.highlighted = false
            self.startStopButton.setTitle("Start", forState: UIControlState.Normal)

        }else {
            self.startStopButton.selected = true
            self.startStopButton.backgroundColor = UIColor.redColor()
            self.pomodoroVC.start(1)
            self.elapsedTimeLabel.highlighted = true
            self.startStopButton.setTitle("Stop", forState: UIControlState.Normal)

        }
    }
    
    //MARK: PomodoroDelegate methods
    
    func pomodoroTimeUpdated(minutes: UInt8, seconds: UInt8) {
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        self.elapsedTimeLabel.text = "\(strMinutes):\(strSeconds)"
    }
    
    func pomodoroFinished() {
        self.startStopButton.selected = false
        self.startStopButton.backgroundColor = UIColor.grayColor()
        self.elapsedTimeLabel.highlighted = false
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
    }


}

