//
//  FirstViewController.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/9/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit
import AVFoundation
import FontAwesome_swift

class MainViewController: UIViewController, PomodoroDelegate {
    let pomodoroVC = PomodoroViewController()
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var pomodoroImg: UIImageView!

    var avPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroVC.delegate = self
        self.pomodoroImg.alpha = CGFloat(0.4)
        self.elapsedTimeLabel.text = "25:00"
        self.pomodoroImg.tintColor = UIColor.grayColor()
        self.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Hourglass2, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        self.tabBarController?.tabBar.items![0].image = UIImage.fontAwesomeIconWithName(.Hourglass2, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        self.tabBarController?.tabBar.items![1].image = UIImage.fontAwesomeIconWithName(.History, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))

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
            self.pomodoroImg.alpha = CGFloat(1.0)
            self.elapsedTimeLabel.alpha = CGFloat(1.0)


        }else {
            self.startStopButton.selected = true
            self.startStopButton.backgroundColor = UIColor.redColor()
            self.pomodoroVC.start(25)
            self.elapsedTimeLabel.highlighted = true
            self.startStopButton.setTitle("Stop", forState: UIControlState.Normal)
            self.blinkPomodoro()
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
        self.pomodoroImg.alpha = CGFloat(1.0)
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alien-siren", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try avPlayer = AVAudioPlayer(contentsOfURL: sound)
            avPlayer.prepareToPlay()
            avPlayer.play()
            
        }catch {
            print("Error trying to play a sound at url \(sound)")
        }
        
        let alert = UIAlertController(title: "Congratulations, dude!", message: "Pomodoro finished!", preferredStyle: UIAlertControllerStyle.Alert);
        alert.addAction(UIAlertAction(title: "Nice", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            
            self.avPlayer.stop()
            self.elapsedTimeLabel.text = "25:00"
            
            UIView.animateWithDuration(0.5, animations: {
                self.pomodoroImg.alpha = CGFloat(1.0)
                self.startStopButton.backgroundColor = UIColor.grayColor()
                self.elapsedTimeLabel.highlighted = false
                self.elapsedTimeLabel.alpha = 1.0
                self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
            })
        }))
        showViewController(alert, sender: self)

    }
    
    func blinkPomodoro() {
        var alpha = CGFloat(self.pomodoroImg.alpha)
        if (CGFloat(UInt8(alpha)) == CGFloat(UInt8(0.2))) {
            alpha = CGFloat(1.0)
        } else {
            alpha = CGFloat(0.2)
        }
        UIView.animateWithDuration(1.3, animations: { () -> Void in
            self.pomodoroImg.alpha = alpha
            self.elapsedTimeLabel.alpha = alpha
            }) { (Bool) -> Void in
                if(self.pomodoroVC.pomodoro.currentState == RLMPomodoro.PomodoroState.pomodoroStateRunning) {
                    self.blinkPomodoro()
                }
        }
    }
}

