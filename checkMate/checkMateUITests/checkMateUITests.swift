//
//  checkMateUITests.swift
//  checkMateUITests
//
//  Created by Miracle John Octavio Jr on 27/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import XCTest

class checkMateUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
             
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Fri, 25 Aug 2017, 08:00 AM").buttons["Button"].tap()
        tablesQuery.staticTexts["Study Swift"].tap()
        app.buttons["Return"].tap()
        tablesQuery.staticTexts["(Chimes)"].tap()
        tablesQuery.staticTexts["Constellation"].tap()
        tablesQuery.buttons["+3 Hours"].tap()
        tablesQuery.switches["Alarm"].tap()
        app.navigationBars["Edit"].buttons["Save"].tap()
        
        app.tabBars.buttons["How to"].tap()
        app.images["obOne.png"].swipeLeft()
        app.images["obTwo.png"].swipeLeft()
    }
    
}
