//
//  CinemaServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import CoreData
@testable import cinego

class CinemaServiceTests: XCTestCase {
    
    var cinemaService: ICinemaService!
    var cinemaRepo: CinemaCoreDataRepository!
    
    override func setUp() {
        super.setUp()
        self.cinemaRepo = CinemaCoreDataRepository(
        self.cinemaService = CinemaService(cinemaRepository: cinemaRepo as! CinemaCoreDataRepository)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}

class MockCinema {}

class MockCinemaRepository: CinemaCoreDataRepository {
    typealias T = MockCinema
    func find(byId: String) -> MockCinema? { return nil }
    func findAll() -> [MockCinema] { return [] }
    func update(_ entity: MockCinema) throws -> MockCinema? { return nil }
    func insert(_ entity: MockCinema) throws -> MockCinema? { return nil }
    func create() -> MockCinema { return MockCinema() }
    func delete(_ entity: MockCinema) throws -> Bool { return false }
}
