//
//  SeatRepository.swift
//  cinego
//
//  Created by Victor Orosco on 16/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ISeatRepository {
    func getSeatCoordinates(byCinema cinema: Cinema) -> [(Int, Int)]
}

class SeatRepository: ISeatRepository {
    func getSeatCoordinates(byCinema cinema: Cinema) -> [(Int, Int)] {
        return [(0,0)]
    }
}
