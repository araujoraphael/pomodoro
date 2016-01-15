//
//  SecondViewController.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/9/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

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
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    //MARK: UITableViewDataSource Methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RLMPomodoro.pomodorosByDate(pomodorosDistinctDates[section] as! String).count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return pomodorosDistinctDates.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if #available(iOS 9.0, *) {
            UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textAlignment = NSTextAlignment.Center
        }

        return pomodorosDistinctDates[section] as! String
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63.0
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.redColor()//UIColor(red: 236/255.0, green: 118/255.0, blue: 108/255.0, alpha: 1.0)
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        pomodoros = RLMPomodoro.pomodorosByDate(pomodorosDistinctDates[indexPath.section] as! String)

        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! HistoryTableViewCell
        cell.pomodoro = pomodoros[indexPath.row] as! RLMPomodoro

        return cell
    }

}

