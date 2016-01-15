//
//  RLMPomodoro.swift
//  SuperPlayerPomodoro
//
//  Created by Raphael Araújo on 1/11/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import Foundation
import RealmSwift


//enum PomodoroState : String {
//    case pomodoroStateInitial = "initial"
//    case pomodoroStateRunning = "running"
//    case pomodoroStateStopped = "stopped"
//    case pomodoroStateFinished = "finished"
//}

class RLMPomodoro: Object {
    @objc
    enum PomodoroState : Int, CustomStringConvertible {
        case pomodoroStateInitial, pomodoroStateRunning, pomodoroStateStopped, pomodoroStateFinished
        
        var description : String {
            switch self {
            case .pomodoroStateInitial: return "initial"
            case .pomodoroStateRunning: return "running"
            case .pomodoroStateStopped: return "stopped"
            case .pomodoroStateFinished: return "finished"
            }
        }
    }
    
    dynamic var initialTimeInterval : Int = 25
    dynamic var elapsedTime : Int = 0
    dynamic var startedAt : NSDate = NSDate()
    dynamic var stoppedAt : NSDate = NSDate()
    dynamic var stoppedAtStr : String = ""
    dynamic var currentState : PomodoroState = PomodoroState.pomodoroStateInitial
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(self)
            })
        }catch {
            print(">>> Fail trying to write pomodoro object")
        }
    }
    
    class func list() -> NSArray {
        var pomodoros = NSArray()
        do {
            let pomodorosResult = try Realm().objects(RLMPomodoro).sorted("startedAt", ascending: false)
            pomodoros = pomodorosResult.map{$0}
        } catch {
            print(">>> Error while trying to list pomodoros")
        }
        return pomodoros
    }
    
    class func distinctPomodoroDates() -> NSArray {
        var distinctDates = [String]()
        do {
            let pomodoros = try Realm().objects(RLMPomodoro).sorted("stoppedAt", ascending: false).map{$0.stoppedAt}
            for pomodoro in pomodoros {
                let startedDate = pomodoro as NSDate
                let friendlyDate = PomodoroUtils.getFriendlyStringFromDate(startedDate, dateFormat: "yyyy-MM-dd", timeZone: NSTimeZone.systemTimeZone().name)
                if !distinctDates.contains(friendlyDate){
                    distinctDates.append(friendlyDate)
                }
            }
        } catch {
            print(">>> Error while trying to list distinct pomodoro")

        }
       return distinctDates
    }
    class func pomodorosByDate(dateStr: String) -> NSArray {
        var pomodorosByDate = NSArray()
        do {
            let pomodorosResult = try Realm().objects(RLMPomodoro).filter("stoppedAtStr == %@", dateStr).sorted("stoppedAt", ascending: false)
            pomodorosByDate = pomodorosResult.map{$0}
        } catch {
            print(">>> Error while trying to list pomodoros")
        }
        return pomodorosByDate
    }
}
