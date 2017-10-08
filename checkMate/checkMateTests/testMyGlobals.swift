//
//  testMyGlobals.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 8/10/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import XCTest
@testable import checkMate // This will allow us to access everything inside of our project

class testMyGlobals: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testmGetDateFormat() {
        let objMyGlobals = MyGlobals()
        
        XCTAssertEqual(objMyGlobals.mGetDateFormat(genmDateFormat.HrsMin), "hh:mm a") // "hh:mm a"
    }
    
    func testmDateToString() {
        let objMyGlobals = MyGlobals()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy mm dd"
        let olddate = formatter.date(from: "2017 01 01")

        // Temp Test
        // print(objMyGlobals.mDateToString(olddate!,genmDateFormat.MonDayYrs))
        
        XCTAssertEqual(objMyGlobals.mDateToString(olddate!,genmDateFormat.MonDayYrs), "Jan 01 2017") // "Jan 01 2017"
    }
    
    func testmSecondsToHoursMinutesSeconds() {
        let objMyGlobals = MyGlobals()
        let strHoursMinutesSeconds: String = objMyGlobals.mSecondsToHoursMinutesSeconds(300000)
        
        // Temp Test
        // print(strHoursMinutesSeconds)
        
        XCTAssertEqual(strHoursMinutesSeconds, "83h 20m 0s")
    }
    
    func testmSecondsToDays() {
        let objMyGlobals = MyGlobals()
        let strToDays: String = objMyGlobals.mSecondsToDays(300000)
        
        // Temp Test
        // print(strToDays)
        
        XCTAssertEqual(strToDays, "3d")
    }

         
}
