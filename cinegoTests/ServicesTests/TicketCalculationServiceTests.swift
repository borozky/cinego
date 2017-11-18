//
//  TicketCalculationServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import PromiseKit
@testable import cinego

class TicketCalculationServiceTests: XCTestCase {
    
    var ticketCalculationService: ITicketCalculationService!
    
    override func setUp() {
        super.setUp()
        self.ticketCalculationService = TicketCalculationService() // no deps
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_1Ticket_Cost20Dollars() {
        let ex = expectation(description: "")
        let numberOfTickets = 1
        let expectedPrice = 20.00
        let future = ticketCalculationService.calculate(totalPriceOfTickets: numberOfTickets)
        
        future.then { totalPrice -> Void in
            XCTAssertEqual(totalPrice, expectedPrice)
        }.catch { error in
            XCTFail("Failed to calculate price")
        }.always {
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_100Tickets_Cost2000Dollars() {
        let ex = expectation(description: "")
        let numberOfTicktets = 100
        let expectedPrice = 2000.00
        let future = ticketCalculationService.calculate(totalPriceOfTickets: numberOfTicktets)
        
        future.then { totalPrice -> Void in
            XCTAssertEqual(totalPrice, expectedPrice)
        }.catch { error in
            XCTFail("Failed to calculate price")
        }.always {
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
