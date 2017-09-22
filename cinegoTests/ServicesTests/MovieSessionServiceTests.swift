//
//  MovieSessionServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 22/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest

class MovieSessionServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ValidFirebaseDate_NotNil() {
        let sampleTime = "2017-11-02T017:09:41+10:00"
        let format = "yyyy-MM-dd'T'HH:mm:ssxxx"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: sampleTime)
        
        XCTAssertNotNil(date)
        print("DATE: ", date!)
    }
    
    func test_ValidFirebaseDate(){
        let sampleTime = "2017-11-02T017:09:41+10:00"
        let format = "yyyy-MM-dd'T'HH:mm:ssxxx"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: sampleTime)
        let dateStr = String(describing: date!)
        
        XCTAssertEqual(dateStr, "2017-11-02 07:09:41 +0000") // London Time is -10 hours
    }
    
    func test_InvalidFirebaseDate_IsNil() {
        let sampleTimeWithMissingT = "2017-11-02 017:09:41+10:00" // missing 'T'
        let format = "yyyy-MM-dd'T'HH:mm:ssxxx"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: sampleTimeWithMissingT)
        XCTAssertNil(date)
    }
    
}
