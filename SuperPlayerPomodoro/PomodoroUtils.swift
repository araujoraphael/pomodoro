//
//  PomodoroUtils.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/12/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class PomodoroUtils: NSObject {
    class func getFriendlyStringFromDate(date: NSDate, dateFormat: String, timeZone: String) -> String {
        var friendlyString = ""
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        friendlyString = dateFormatter.stringFromDate(date)
        
        return friendlyString
    }
    
    class func getFriendlyTimeStringFormatFromSeconds(value: Int) -> String {
        let minutes = UInt8(value/60)
        let seconds = value - Int(minutes*60)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        return "\(strMinutes):\(strSeconds)"
    }
    
    class func differenceInHoursOfTwoDates(date1: NSDate, date2: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date1, toDate: date2, options: []).hour
    }
    
    class func differenceInMinutesOfTwoDates(date1: NSDate, date2: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date1, toDate: date2, options: []).minute
    }
    
    class func differenceInSecondsOfTwoDates(date1: NSDate, date2: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Second, fromDate: date1, toDate: date2, options: []).second
    }
}
