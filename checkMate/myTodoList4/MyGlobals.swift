//
//  globalMethods.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 10/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//
//

import Foundation
import UIKit // mjNotes: Added

/*
 
 Note: 
 Naming Convention Reference: https://msdn.microsoft.com/en-us/library/aa240858(v=vs.60).aspx
 
*/


// Core Data
let gObjAppDelegate = UIApplication.shared.delegate as! AppDelegate     // This requires UIKit
let gObjContext = gObjAppDelegate.persistentContainer.viewContext

// MARK: - For Deletion

// Structure
struct gstruTask {
    var Task = String()
    var IsTaskComplete = Int()
    var DateTime = Date()
    var IsAlarmMessageOn = Int()
    var ToneId = Int()
    var IconFile = String()
}

// Enumeration
enum genmDateFormat: String {
    case WekDayMonYrsHrsMinSec
    case WekDayMonYrsHrsMin
    case WekDayMonHrsMin
    case DayMonYrsHrsMin
    case MonDayYrs
    case HrsMin
    case HrsMinSec
}
enum genmOperation: Int {
    case Add = 1
    case Edit = 2
}

class MyGlobals {
    
// MARK: - Initialization
    
    private init() {
    }
    
// MARK: - Variables
    
    // Global Shared
    static let shared = MyGlobals()
    
    // Arrays - Transaction   
    var arrMyTask: [Task] = []

    var arrTask = [gstruTask]()             // Mark: To Delete
    var arrTask_Lookup = gstruTask()
    
    // Arrays - Master File (Lookup)
    var arrTone = [String]()
    var arrIconFile = [String]()    // This will hold the Icon File (e.g. "01.png")
    
    // Images
    let imgChecked = UIImage(named: "Check.png")
    let imgUnChecked = UIImage(named: "unCheck.png")
    let imgChecked_Small = UIImage(named: "Check_Small.png")
    let imgUnChecked_Small = UIImage(named: "unCheck_Small.png")
    
    
// MARK: - Methods
    
    // ---------- Initialize - This is called only once
    
    func mInitialize() {
        
        // ---------- Master File (Lookup)
        
        // Tone
        arrTone = mStringToArray("Apex,Beacon,Bulletin,By The Seaside,Chimes,Circuit,Constellation,Cosmic,Crystals")
        
        // Icon File
        for i in 1 ..< 28 {
            if (i < 10) {
                arrIconFile.append("0" + String(i) + ".png")
            } else {
                arrIconFile.append(String(i) + ".png")
            }
        }
        
        // ---------- Dummy Data
        
        var arrTaskList = mStringToArray("Exercise,I will be going to the train station to catch up the train going to Melbourne Central,Study Swift")
        var arrTaskCompleted = [1, 0, 0]
        var arrTaskDateTime = mStringToArray(
            mDateToString(mStringToDate("24 AUG 2017, 08:00 am",.DayMonYrsHrsMin)) + "|" +
            mDateToString(mStringToDate("25 AUG 2017, 08:00 am",.DayMonYrsHrsMin)) + "|" +
            mDateToString(mStringToDate("26 AUG 2017, 07:00 pm",.DayMonYrsHrsMin)),"|")
        var arrIsAlarmMessageOn = [1, 1, 0]
        var arrToneId = [1, 1, 4]
        var arrIconFile_Dummy = mStringToArray("01.png,06.png,09.png")
        for i in 0 ..< arrTaskList.count {
            
            // Create local strucuture
            var lStruTask = gstruTask()
            
            // Pass the dummy values to respective elements of the Structure
            lStruTask.Task = arrTaskList[i]
            lStruTask.IsTaskComplete = arrTaskCompleted[i]
            lStruTask.DateTime = mStringToDate(arrTaskDateTime[i])
            lStruTask.IsAlarmMessageOn = arrIsAlarmMessageOn[i]
            lStruTask.ToneId = arrToneId[i]
            lStruTask.IconFile = arrIconFile_Dummy[i]
            
            // Add the structure to Array
            MyGlobals.shared.arrTask.append(lStruTask)
        }

    }
    
    // ---------- Conversion
    
    func mDateToString(_ dteDateValue: Date, _ enmDateFormat: genmDateFormat = genmDateFormat.WekDayMonYrsHrsMin) -> String {
        var dateFormat: String = ""
        let clsDateFormatter = DateFormatter()
        
        dateFormat = mGetDateFormat(enmDateFormat)
        
        clsDateFormatter.dateFormat = dateFormat
        let strDate: String = clsDateFormatter.string(from: dteDateValue)
        return strDate
    }

    func mStringToDate(_ strDateValue: String, _ enmDateFormat: genmDateFormat = genmDateFormat.WekDayMonYrsHrsMin) -> Date {
        var dateFormat: String = ""
        let clsDateFormatter = DateFormatter()
        
        dateFormat = mGetDateFormat(enmDateFormat)
        
        clsDateFormatter.dateFormat = dateFormat
        let dteDate: Date = clsDateFormatter.date(from: strDateValue)!
        return dteDate
    }
    
    func mDateToDate(_ dteDateValue: Date, _ enmDateFormat: genmDateFormat = genmDateFormat.WekDayMonYrsHrsMinSec) -> Date {
        var dateFormat: String = ""
        let clsDateFormatter = DateFormatter()
        
        dateFormat = mGetDateFormat(enmDateFormat)
        
        clsDateFormatter.dateFormat = dateFormat
        let strDate: String = clsDateFormatter.string(from: dteDateValue)
        return mStringToDate(strDate,enmDateFormat)
    }
    
    func mGetDateFormat(_ enmDateFormat: genmDateFormat) -> String {
        var strRetDateFormat: String = ""
        switch enmDateFormat {
        case .WekDayMonYrsHrsMinSec:
            strRetDateFormat = "EEE, dd MMM yyyy, hh:mm:ss a"
        case .WekDayMonYrsHrsMin:
            strRetDateFormat = "EEE, dd MMM yyyy, hh:mm a"
        case .WekDayMonHrsMin:
            strRetDateFormat = "EEE, dd MMM, hh:mm a"
        case .DayMonYrsHrsMin:
            strRetDateFormat = "dd MMM yyyy, hh:mm a"
        case .MonDayYrs:
            strRetDateFormat = "MMM dd yyyy"
        case .HrsMin:
            strRetDateFormat = "hh:mm a"
        case .HrsMinSec:
            strRetDateFormat = "hh:mm:ss a"
        }
        return strRetDateFormat
    }
    
    func mStringToArray(_ strDelimited: String, _ separatingChar: String = ",") -> [String] {
        var arrReturnValue = [String]()
        arrReturnValue = (strDelimited).components(separatedBy: separatingChar)
        return arrReturnValue
    }
    
    func mSecondsToHoursMinutesSeconds(_ seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func mSecondsToHoursMinutesSeconds(_ seconds:Int) -> String {
        let (h, m, s) = mSecondsToHoursMinutesSeconds(seconds)
        return ("\(h)h \(m)m \(s)s")
    }
    
    func mSecondsToHoursMinutes(_ seconds:Int) -> String {
        let (h, m, s) = mSecondsToHoursMinutesSeconds(seconds)
        return ("\(h)h \(m)m")
    }
}









