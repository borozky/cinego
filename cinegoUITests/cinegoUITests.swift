//
//  cinegoUITests.swift
//  cinegoUITests
//
//  Created by Victor Orosco on 23/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest

class cinegoUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWholeApplicationWorkFlow() {
    
        
//        var elementsQuery = XCUIApplication().scrollViews.otherElements
//        elementsQuery.collectionViews.cells.otherElements.containing(.image, identifier:"alien_covenant").element.tap()
//        elementsQuery.tables.staticTexts["Tue 04 Apr 04:12 AM"].tap()
//        
//        let incrementButton = elementsQuery.steppers.buttons["Increment"]
//        incrementButton.tap()
//        incrementButton.tap()
//        incrementButton.tap()
//        incrementButton.tap()
//        
//    
//        var collectionViewsQuery = app.collectionViews
//        collectionViewsQuery.staticTexts["A4"].tap()
//        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"B4").element.tap()
//        collectionViewsQuery.staticTexts["B3"].tap()
//        collectionViewsQuery.staticTexts["C2"].tap()
//        app.navigationBars["cinego.SeatsCollectionVC"].buttons["Booking Details"].tap()
//        
//        let scrollViewsQuery = app.scrollViews
//        elementsQuery = scrollViewsQuery.otherElements
//        elementsQuery.buttons["Book"].tap()
//        app.tabBars.buttons["Cart"].tap()
//        elementsQuery.tables.staticTexts["Alien Covenant"].tap()
//        elementsQuery.steppers.buttons["Increment"].tap()
//        scrollViewsQuery.children(matching: .other).element.tap()
//        
//        collectionViewsQuery = app.collectionViews
//        collectionViewsQuery.staticTexts["D1"].tap()
//        collectionViewsQuery.staticTexts["D2"].tap()
//        collectionViewsQuery.staticTexts["C3"].tap()
//        collectionViewsQuery.staticTexts["C4"].tap()
//        collectionViewsQuery.staticTexts["D4"].tap()
//        app.navigationBars["cinego.SeatsCollectionVC"].buttons["Booking Details"].tap()
//        app.navigationBars["Booking Details"].buttons["Cart"].tap()
//        app.navigationBars["Cart"].buttons["Checkout"].tap()
//        app.scrollViews.otherElements.tables.staticTexts["Payment method"].tap()
//        app.buttons["Place Order"].tap()
//        app.navigationBars["ORDER SUMMARY"].buttons["Exit"].tap()
//        
        
        
    }
    
}
