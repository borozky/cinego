//
//  MockTMDBService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
@testable import cinego

enum MockTMDBError: Error {
    case NotFound(String)
}

class MockTMDBService: ITMDBMovieService {
    var items: [[String: Any]] = [
        [
            "id" : "12345",
            "title": "Sample Movie",
            "release_date": "2016-04-25",
            "runtime": "124",
            "overview": "Lorem ipsum",
            "poster_path": "http://example.com"
        ]
    ]
    
    
    func findTMDBMovie(_ id: Int) -> Promise<SwiftyJSON.JSON> {
        return Promise { fulfill, reject in
            let results = items.filter { item in
                let itemID = item["id"] as! String
                return itemID == String(id)
            }
            guard results.count > 0 else {
                reject(MockTMDBError.NotFound("Movie not found"))
                return
            }
            
            fulfill(JSON(results.first!))
        }
    }
}
