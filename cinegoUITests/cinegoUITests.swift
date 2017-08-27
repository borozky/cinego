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
    
    func testBasicUseCaseScenario(){
        let app = XCUIApplication()
        
        // tap a movie
        let upcomingMoviesCellsQuery = app.tables.cells.containing(.staticText, identifier:"Upcoming Movies")
        upcomingMoviesCellsQuery.images.element(boundBy: 0).tap()
        
        
        // tap a movie session
        app.tables.children(matching: .cell).matching(identifier: "sessions").element(boundBy: 0).staticTexts["session-times"].tap()
        app.swipeUp()
        
        
        // select a seat
        app.scrollViews.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        app.scrollViews.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .collectionView).element.swipeRight()
        let collectionViewsQuery = app.scrollViews.otherElements.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        
        
        // proceed to checkout
        app.buttons["Proceed to Checkout"].tap()
        app.swipeUp()
        app.swipeLeft()
        app.swipeRight()
        
        
        // login with username: s3485376, password: 12345
        app.buttons["Login to place your order"].tap()
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("s3485376")
        app.secureTextFields["password-field"].tap()
        app.secureTextFields["password-field"].typeText("12345")
        app.buttons["Login"].tap()
        
        
        // place your order
        app.buttons["Place order"].tap()
        
        
        // order summary
        app.swipeUp()
        app.navigationBars["ORDER SUMMARY"].buttons["Exit"].tap()
        
        
        
    }
    
}
