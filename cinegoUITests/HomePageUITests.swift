//
//  HomePageUITests.swift
//  cinego
//
//  Created by 何家红 on 21/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest

class HomePageUITests: XCTestCase {
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
       
        continueAfterFailure = false
       
       app.launch()

    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    func testHomePageTitleLables(){
        XCTAssert(app.staticTexts["CINEGO"].exists)
        XCTAssert(app.staticTexts["UPCOMING MOVIES"].exists)
        XCTAssert(app.staticTexts["CINEMA THEATERS"].exists)
    }
    
    
    func testThatUpcomingMovies_HasAtLeastOneItem() {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.collectionViews.cells.otherElements.containing(.image, identifier:"alien_covenant").element.tap()
        elementsQuery.staticTexts["Alien Covenant"].tap()
        elementsQuery.staticTexts["Released: 19 May 2017"].tap()
        elementsQuery.staticTexts["Duration 122 minutes"].tap()
        elementsQuery.buttons["Additional Information"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Alien Covenant"].tap()
        tablesQuery.staticTexts["Released: 2017"].tap()
        tablesQuery.staticTexts["Duration: 122 minutes"].tap()
        tablesQuery.staticTexts["Rating: "].tap()
        tablesQuery.staticTexts["Bound for a remote planet on the far side of the galaxy, the crew of the colony ship 'Covenant' discovers what is thought to be an uncharted paradise, but is actually a dark, dangerous world – which has its sole inhabitant the 'synthetic', David, survivor of the doomed Prometheus expedition."].tap()
        
    }
    
    
}
