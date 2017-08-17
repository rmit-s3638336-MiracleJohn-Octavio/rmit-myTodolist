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


// Structures
struct gstruTask {
    var Task = String()
    var IsTaskComplete = Int()
    var DateTime = Date()
    var IsAlarmMessageOn = Int()
}

// Enumeration
enum genmDateFormat: String {
    case WekDayMonYrsHrsMin
    case WekDayMonHrsMin
    case MonDayYrs
    case HrsMin
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
    
    // Array
    var arrTask = [gstruTask]()
    
    // Images
    let imgChecked = UIImage(named: "Check.png")
    let imgUnChecked = UIImage(named: "unCheck.png")
    
    
// MARK: - Methods
    
    
    // Conversion
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
    
    func mDateToDate(_ dteDateValue: Date, _ enmDateFormat: genmDateFormat = genmDateFormat.WekDayMonYrsHrsMin) -> Date {
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
        case .WekDayMonYrsHrsMin:
            strRetDateFormat = "EEE, dd MMM yyyy, hh:mm a"
        case .WekDayMonHrsMin:
            strRetDateFormat = "EEE, dd MMM, hh:mm a"
        case .MonDayYrs:
            strRetDateFormat = "MMM dd yyyy"
        case .HrsMin:
            strRetDateFormat = "hh:mm a"
        }
        return strRetDateFormat
    }
    
    func mStringToArray(_ strDelimited: String, _ separatingChar: String = ",") -> [String] {
        var arrReturnValue = [String]()
        arrReturnValue = (strDelimited).components(separatedBy: separatingChar)
        return arrReturnValue
    }
}









