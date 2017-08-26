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
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Upcoming Movies").children(matching: .image).matching(identifier: "movies").element(boundBy: 0).tap()
        app.tables.cells.containing(.staticText, identifier: "session-times").element(boundBy: 0).tap()
        
        let collectionViewsQuery = XCUIApplication().scrollViews.otherElements.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        XCUIApplication().buttons["Proceed to Checkout"].tap()
        
        let table = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.swipeUp()
        table.swipeUp()
        table.swipeLeft()
        table.swipeLeft()
        table.swipeDown()
        table.swipeDown()
        app.buttons["Login to place your order"].tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("s3485376")
        
        let passwordFieldSecureTextField = app.secureTextFields["Password"]
        passwordFieldSecureTextField.tap()
        passwordFieldSecureTextField.typeText("12345")
        
        app.buttons["Login"].tap()
        app.buttons["Place order"].tap()
        
        let paymentDetailsTable = app.tables.containing(.other, identifier:"PAYMENT DETAILS").element
        paymentDetailsTable.swipeUp()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeLeft()
        
        XCUIApplication().navigationBars["ORDER SUMMARY"].buttons["Exit"].tap()
        
    }
    
    func testAlternativeWorkflow() {
        let upcomingMoviesCellsQuery = XCUIApplication().tables.cells.containing(.staticText, identifier:"Upcoming Movies")
        upcomingMoviesCellsQuery.images.element(boundBy: 0).tap()
        
        let app = XCUIApplication()
        app.tables.children(matching: .cell).matching(identifier: "sessions").element(boundBy: 0).staticTexts["session-times"].tap()
        app.scrollViews.children(matching: .other).element.swipeUp()
        XCUIApplication().scrollViews.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        XCUIApplication().scrollViews.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .collectionView).element.swipeRight()
        
        let collectionViewsQuery = XCUIApplication().scrollViews.otherElements.collectionViews
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 8).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 9).children(matching: .other).element.tap()
        
        XCUIApplication().scrollViews.otherElements.staticTexts["price-label"].tap()
        XCUIApplication().scrollViews.otherElements.staticTexts["price-calculation"].tap()
        
        XCUIApplication().buttons["Proceed to Checkout"].tap()
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeUp()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeUp()
        
        
        app.buttons["Login to place your order"].tap()
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("s3485376")
        
        app.secureTextFields["password-field"].tap()
        app.secureTextFields["password-field"].typeText("12345")
        
        XCUIApplication().buttons["Login"].tap()
        
        app.buttons["Place order"].tap()
        XCUIApplication().tables.staticTexts["Payment details"].swipeUp()
        
        let table = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.swipeUp()
        XCUIApplication().navigationBars["ORDER SUMMARY"].buttons["Exit"].tap()
        
    }
    
}
