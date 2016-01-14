//
//  SecondViewController.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/9/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    var pomodoros : NSArray = NSArray()
    var pomodorosDistinctDates : NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")
        self.tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        pomodoros = RLMPomodoro.list()
        pomodorosDistinctDates = RLMPomodoro.distinctPomodoroDates()
        //print("\(pomodoros)")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDelegate Methods
    
    //MARK: UITableViewDataSource Methods

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pomodoros.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return pomodorosDistinctDates.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextAlignment:NSTextAlignmentCenter];
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textAlignment = NSTextAlignment.Center

        return pomodorosDistinctDates[section] as? String
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63.0
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 236/255.0, green: 118/255.0, blue: 108/255.0, alpha: 1.0)
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! HistoryTableViewCell

        cell.pomodoro = pomodoros[indexPath.row] as! RLMPomodoro
        
        print(">>>> CurrentState \(pomodoro.currentState.rawValue)")
        cell.currentStatusLabel!.text = pomodoro.currentState.description
        cell.stoppedTimeLabel!.text = PomodoroUtils.getFriendlyTimStringFormatFromSeconds(pomodoro.elapsedTime)
        
        return cell
    }

}

