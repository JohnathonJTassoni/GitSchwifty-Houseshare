//
//  HouseshareUITests.swift
//  HouseshareUITests
//
//  Created by Johnathon Tassoni on 2/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import XCTest

class HouseshareUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBillsHaveLoaded()
    {
        //The bills view model has 4 bills by default, we will check if the load corerctly and are inserted into cells
        
        XCUIApplication().tabBars.buttons["Bills"].tap()
        XCUIApplication().tables.element.swipeUp()
       
        XCTAssertEqual(XCUIApplication().tables.cells.count, 4)
        
    }
    
  
    func testCreateBillLoaded()
    {
        //Check to see if we can add a new bill, click submit and have the bill appear in the Table View
        
        XCUIApplication().tabBars.buttons["Bills"].tap()
        XCUIApplication().navigationBars["Bills"].buttons["Add Bill"].tap()
        

        XCUIApplication().textFields["Amount"].tap()
        sleep(3)
        XCUIApplication().textFields["Amount"].typeText("345")
        sleep(2)
        XCUIApplication().staticTexts["Add New Bill"].tap() // To dismiss keyboard
        sleep(2)
        XCUIApplication().buttons["Submit"].tap()
        
        //If there are 5 bills, a new bill has been added
        XCTAssertEqual(XCUIApplication().tables.cells.count, 5)

        
    }
    
    func testCreateChoreLoaded()
    {
        
        XCUIApplication().tabBars.buttons["Chores"].tap()
        XCUIApplication().navigationBars["Chores"].buttons["Add"].tap()
        XCUIApplication().textFields["Enter the name of the chore"].tap()
        sleep(3)
        XCUIApplication().textFields["Enter the name of the chore"].typeText("Mow the Lawn")
        sleep(2)
        XCUIApplication().staticTexts["Name"].tap()
        XCUIApplication().navigationBars["Add New Chore"].buttons["Submit"].tap()
        
        XCTAssertEqual(XCUIApplication().tables.cells.count, 3)

        
    }
    
    func testCreateContactLoaded()
    {
        
        XCUIApplication().tabBars.buttons["Contacts"].tap()
        XCUIApplication().navigationBars["Contacts"].buttons["Add"].tap()
        XCUIApplication().textFields["First name"].tap()
        sleep(3)
        XCUIApplication().textFields["First name"].typeText("John")
        sleep(2)
        XCUIApplication().textFields["Surename"].tap()
        sleep(3)
        XCUIApplication().textFields["Surename"].typeText("Doe")
        sleep(2)
        XCUIApplication().staticTexts["First Name"].tap()
        
        XCUIApplication().buttons["Submit"].tap()
        
        XCTAssertEqual(XCUIApplication().tables.cells.count, 5)

        
    }
    
    func testLoadProfileDetail()
    {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
